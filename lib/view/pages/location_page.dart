// ignore_for_file: deprecated_member_use

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:pharmacy_app/components/horizintal_list_widget.dart';
import 'package:pharmacy_app/data/pharmacy_data.dart';
import 'package:pharmacy_app/view/pages/home_page.dart';

const double _kWorld = 2000; // size of the drawn map in logical pixels

// ===========================================================================
// PAGE
// ===========================================================================
class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage>
    with TickerProviderStateMixin {
  static const double _maxScale = 4.0;

  final TransformationController _transform = TransformationController();
  late final AnimationController _anim = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 60),
  )..repeat();
  late final AnimationController _move = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 450),
  );

  final _MapGeometry _geo = _MapGeometry.instance;

  Size _viewport = Size.zero;
  double _minScale = 0.3;
  bool _ready = false;
  bool _initScheduled = false;
  int? _selected = 0;

  @override
  void dispose() {
    _anim.dispose();
    _move.dispose();
    _transform.dispose();
    super.dispose();
  }

  // ---- Camera helpers ------------------------------------------------------

  /// Matrix that puts [sceneCenter] in the middle of the viewport at [scale],
  /// kept inside the map bounds.
  Matrix4 _matrixFor(Offset sceneCenter, double scale) {
    final s = scale.clamp(_minScale, _maxScale).toDouble();
    final tx = (_viewport.width / 2 - sceneCenter.dx * s)
        .clamp(_viewport.width - _kWorld * s, 0.0)
        .toDouble();
    final ty = (_viewport.height / 2 - sceneCenter.dy * s)
        .clamp(_viewport.height - _kWorld * s, 0.0)
        .toDouble();
    return Matrix4(
      s,
      0,
      0,
      0, //
      0,
      s,
      0,
      0, //
      0,
      0,
      1,
      0, //
      tx,
      ty,
      0,
      1,
    );
  }

  void _animateTo(Matrix4 target) {
    final anim = Matrix4Tween(
      begin: _transform.value,
      end: target,
    ).animate(CurvedAnimation(parent: _move, curve: Curves.easeOutCubic));
    void tick() => _transform.value = anim.value;
    anim.addListener(tick);
    _move.forward(from: 0).whenComplete(() => anim.removeListener(tick));
  }

  void _zoomBy(double factor) {
    final scale = _transform.value.getMaxScaleOnAxis();
    final center = _transform.toScene(
      Offset(_viewport.width / 2, _viewport.height / 2),
    );
    _animateTo(_matrixFor(center, scale * factor));
  }

  void _recenter() => _animateTo(_matrixFor(_geo.you, 0.8));

  void _select(int index) {
    setState(() => _selected = index);
    final scale = math.max(_transform.value.getMaxScaleOnAxis(), 0.9);
    // Shift the focus point down so the pin sits above the bottom list.
    final target = _geo.pharmacies[index].translate(0, 110 / scale);
    _animateTo(_matrixFor(target, scale));
  }

  void _onTap(TapUpDetails details) {
    final k = 1 / _transform.value.getMaxScaleOnAxis();
    int? hit;
    double best = double.infinity;
    for (int i = 0; i < _geo.pharmacies.length; i++) {
      final p = _geo.pharmacies[i];
      final pinCenter = Offset(p.dx, p.dy - 20 * k);
      final dist = (details.localPosition - pinCenter).distance;
      if (dist < 26 * k && dist < best) {
        best = dist;
        hit = i;
      }
    }
    if (hit != null) {
      _select(hit);
    } else {
      setState(() => _selected = null);
    }
  }

  // ---- UI --------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final names = [
      for (int i = 0; i < _geo.pharmacies.length; i++)
        i < pharmacies.length ? pharmacies[i].toString() : 'Pharmacy ${i + 1}',
    ];

    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(
                child: LayoutBuilder(
                  builder: (context, c) {
                    _viewport = Size(c.maxWidth, c.maxHeight);
                    _minScale = math.max(
                      math.max(_viewport.width, _viewport.height) / _kWorld,
                      0.2,
                    );

                    if (!_ready && !_initScheduled) {
                      _initScheduled = true;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (!mounted) return;
                        _transform.value = _matrixFor(_geo.you, 0.8);
                        setState(() => _ready = true);
                      });
                    }

                    return AnimatedOpacity(
                      opacity: _ready ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: InteractiveViewer(
                        transformationController: _transform,
                        constrained: false,
                        minScale: _minScale,
                        maxScale: _maxScale,
                        boundaryMargin: EdgeInsets.zero,
                        onInteractionStart: (_) => _move.stop(),
                        child: SizedBox(
                          width: _kWorld,
                          height: _kWorld,
                          child: GestureDetector(
                            onTapUp: _onTap,
                            child: Stack(
                              children: [
                                // Static map: painted once and cached.
                                const RepaintBoundary(
                                  child: CustomPaint(
                                    size: Size(_kWorld, _kWorld),
                                    painter: _BasePainter(),
                                  ),
                                ),
                                // Animated layer: cars, pulses, route, pins.
                                RepaintBoundary(
                                  child: CustomPaint(
                                    size: const Size(_kWorld, _kWorld),
                                    painter: _LivePainter(
                                      geo: _geo,
                                      anim: _anim,
                                      transform: _transform,
                                      selected: _selected,
                                      names: names,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Offline badge
              Positioned(
                top: 16,
                left: 12,
                child: SafeArea(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(blurRadius: 6, color: Colors.black26),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.offline_bolt, size: 16, color: Colors.green),
                        SizedBox(width: 6),
                        Text(
                          'Offline karta',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Map controls
              Positioned(
                top: 16,
                right: 12,
                child: SafeArea(
                  child: Column(
                    children: [
                      _MapButton(icon: Icons.add, onTap: () => _zoomBy(1.6)),
                      const SizedBox(height: 8),
                      _MapButton(
                        icon: Icons.remove,
                        onTap: () => _zoomBy(1 / 1.6),
                      ),
                      const SizedBox(height: 8),
                      _MapButton(icon: Icons.my_location, onTap: _recenter),
                    ],
                  ),
                ),
              ),

              // Horizontal list stays exactly as before
              Positioned(
                bottom: 20,
                left: 10,
                right: 10,
                child: HorizontalList(
                  images: pharmacyImage,
                  titles: pharmacies,
                  addresses: adresses,
                  points: 5.0,
                  reviews: "(58 Reviews)",
                  kilometer: "25 km/40min",
                  clinic: location,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MapButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _MapButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 3,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 42,
          height: 42,
          child: Icon(icon, color: Colors.black87, size: 22),
        ),
      ),
    );
  }
}

// ===========================================================================
// MAP DATA (generated once, same every launch)
// ===========================================================================
class _Block {
  final Rect rect;
  final int kind; // 0 = plain, 1 = buildings, 2 = park
  final List<Rect> footprints;
  final List<Offset> trees;

  _Block(this.rect, this.kind, this.footprints, this.trees);
}

class _Car {
  final bool horizontal;
  final int line;
  final double offset;
  final int speed; // whole number so the 60s loop is seamless
  final int dir;
  final Color color;

  _Car(
    this.horizontal,
    this.line,
    this.offset,
    this.speed,
    this.dir,
    this.color,
  );
}

class _MapGeometry {
  _MapGeometry._({
    required this.xs,
    required this.ys,
    required this.xw,
    required this.yw,
    required this.blocks,
    required this.cars,
    required this.pharmacies,
    required this.you,
  });

  static final _MapGeometry instance = _generate();

  static const Offset lakeCenter = Offset(1560, 360);
  static const double lakeRx = 190;
  static const double lakeRy = 100;

  static const List<List<Offset>> diagonals = [
    [Offset(0, 350), Offset(2000, 1450)],
    [Offset(0, 1750), Offset(1450, 0)],
  ];
  static const Offset ringCenter = Offset(1000, 1000);
  static const double ringRadius = 720;

  final List<double> xs, ys, xw, yw;
  final List<_Block> blocks;
  final List<_Car> cars;
  final List<Offset> pharmacies;
  final Offset you;

  static bool inLake(Offset p) {
    final dx = (p.dx - lakeCenter.dx) / lakeRx;
    final dy = (p.dy - lakeCenter.dy) / lakeRy;
    return dx * dx + dy * dy < 1.05;
  }

  static _MapGeometry _generate() {
    final rnd = math.Random(42);

    // Street lines (every 4th one is a wide avenue)
    final xs = <double>[], xw = <double>[];
    double x = 50;
    for (int i = 0; x < _kWorld - 50; i++) {
      xs.add(x);
      xw.add(i % 4 == 0 ? 22 : 9 + rnd.nextDouble() * 4);
      x += 120 + rnd.nextInt(80);
    }
    final ys = <double>[], yw = <double>[];
    double y = 50;
    for (int i = 0; y < _kWorld - 50; i++) {
      ys.add(y);
      yw.add(i % 4 == 0 ? 22 : 9 + rnd.nextDouble() * 4);
      y += 120 + rnd.nextInt(80);
    }

    // City blocks
    final blocks = <_Block>[];
    for (int i = 0; i < xs.length - 1; i++) {
      for (int j = 0; j < ys.length - 1; j++) {
        final r = Rect.fromLTRB(
          xs[i] + xw[i] / 2,
          ys[j] + yw[j] / 2,
          xs[i + 1] - xw[i + 1] / 2,
          ys[j + 1] - yw[j + 1] / 2,
        );
        final roll = rnd.nextDouble();
        final kind = roll < 0.12 ? 2 : (roll < 0.8 ? 1 : 0);

        final footprints = <Rect>[];
        final trees = <Offset>[];
        if (kind == 1) {
          final cols = r.width > 110 ? 2 : 1;
          final rows = r.height > 110 ? 2 : 1;
          final w = r.width / cols, h = r.height / rows;
          for (int c = 0; c < cols; c++) {
            for (int rr = 0; rr < rows; rr++) {
              if (rnd.nextDouble() < 0.85) {
                footprints.add(
                  Rect.fromLTWH(
                    r.left + c * w,
                    r.top + rr * h,
                    w,
                    h,
                  ).deflate(6),
                );
              }
            }
          }
        } else if (kind == 2) {
          final n = 8 + rnd.nextInt(7);
          for (int t = 0; t < n; t++) {
            trees.add(
              Offset(
                r.left + 8 + rnd.nextDouble() * (r.width - 16),
                r.top + 8 + rnd.nextDouble() * (r.height - 16),
              ),
            );
          }
        }
        blocks.add(_Block(r, kind, footprints, trees));
      }
    }

    // Traffic
    const palette = [
      Color(0xFFE53935),
      Color(0xFF1E88E5),
      Color(0xFFFDD835),
      Color(0xFF43A047),
      Color(0xFF8E24AA),
      Color(0xFF424242),
      Color(0xFFFB8C00),
    ];
    final cars = <_Car>[];
    for (int n = 0; n < 48; n++) {
      final horizontal = rnd.nextBool();
      cars.add(
        _Car(
          horizontal,
          rnd.nextInt(horizontal ? ys.length : xs.length),
          rnd.nextDouble(),
          1 + rnd.nextInt(3),
          rnd.nextBool() ? 1 : -1,
          palette[rnd.nextInt(palette.length)],
        ),
      );
    }

    // Pharmacies sit on street intersections
    Offset cell(int i, int j) =>
        Offset(xs[math.min(i, xs.length - 1)], ys[math.min(j, ys.length - 1)]);
    final pharmacies = [
      cell(3, 4),
      cell(7, 3),
      cell(5, 8),
      cell(9, 7),
      cell(10, 10),
    ];

    return _MapGeometry._(
      xs: xs,
      ys: ys,
      xw: xw,
      yw: yw,
      blocks: blocks,
      cars: cars,
      pharmacies: pharmacies,
      you: cell(xs.length ~/ 2, ys.length ~/ 2),
    );
  }
}

// ===========================================================================
// STATIC MAP PAINTER (roads, blocks, parks, lake)
// ===========================================================================
class _BasePainter extends CustomPainter {
  const _BasePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final g = _MapGeometry.instance;

    // Land
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0xFFF1EDE4),
    );

    // Road casings first, fills second, so intersections look clean
    final casing = Paint()..color = const Color(0xFFD9D3C4);
    for (int i = 0; i < g.xs.length; i++) {
      final w = g.xw[i];
      canvas.drawRect(
        Rect.fromLTWH(g.xs[i] - w / 2 - 1.2, 0, w + 2.4, size.height),
        casing,
      );
    }
    for (int j = 0; j < g.ys.length; j++) {
      final w = g.yw[j];
      canvas.drawRect(
        Rect.fromLTWH(0, g.ys[j] - w / 2 - 1.2, size.width, w + 2.4),
        casing,
      );
    }
    final minor = Paint()..color = Colors.white;
    final major = Paint()..color = const Color(0xFFFFF3D0);
    for (int i = 0; i < g.xs.length; i++) {
      final w = g.xw[i];
      canvas.drawRect(
        Rect.fromLTWH(g.xs[i] - w / 2, 0, w, size.height),
        w >= 20 ? major : minor,
      );
    }
    for (int j = 0; j < g.ys.length; j++) {
      final w = g.yw[j];
      canvas.drawRect(
        Rect.fromLTWH(0, g.ys[j] - w / 2, size.width, w),
        w >= 20 ? major : minor,
      );
    }

    // Blocks
    final plain = Paint()..color = const Color(0xFFEAE5DA);
    final built = Paint()..color = const Color(0xFFE6E0D3);
    final park = Paint()..color = const Color(0xFFD3E9C4);
    final footprint = Paint()..color = const Color(0xFFDAD3C4);
    final tree = Paint()..color = const Color(0xFFA9D18E);
    for (final b in g.blocks) {
      final rr = RRect.fromRectAndRadius(b.rect, const Radius.circular(6));
      canvas.drawRRect(rr, b.kind == 2 ? park : (b.kind == 1 ? built : plain));
      for (final f in b.footprints) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(f, const Radius.circular(3)),
          footprint,
        );
      }
      for (final t in b.trees) {
        canvas.drawCircle(t, 5, tree);
      }
    }

    // Diagonal avenues and ring road
    final avenueCasing = Paint()
      ..color = const Color(0xFFE4B964)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;
    final avenueFill = Paint()
      ..color = const Color(0xFFFFD98A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round;
    for (final d in _MapGeometry.diagonals) {
      canvas.drawLine(d[0], d[1], avenueCasing);
    }
    canvas.drawCircle(
      _MapGeometry.ringCenter,
      _MapGeometry.ringRadius,
      avenueCasing,
    );
    for (final d in _MapGeometry.diagonals) {
      canvas.drawLine(d[0], d[1], avenueFill);
    }
    canvas.drawCircle(
      _MapGeometry.ringCenter,
      _MapGeometry.ringRadius,
      avenueFill,
    );

    // Lake
    final lake = Rect.fromCenter(
      center: _MapGeometry.lakeCenter,
      width: _MapGeometry.lakeRx * 2,
      height: _MapGeometry.lakeRy * 2,
    );
    canvas.drawOval(lake, Paint()..color = const Color(0xFFAAD3DF));
    canvas.drawOval(
      lake,
      Paint()
        ..color = const Color(0xFF8FC1D0)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4,
    );

    // City label
    final tp = TextPainter(
      text: const TextSpan(
        text: 'Aşgabat',
        style: TextStyle(
          fontSize: 64,
          fontWeight: FontWeight.w800,
          letterSpacing: 14,
          color: Color(0x2E000000),
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(size.width / 2 - tp.width / 2, 880));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ===========================================================================
// ANIMATED LAYER PAINTER (traffic, route, pulses, pins)
// ===========================================================================
class _LivePainter extends CustomPainter {
  _LivePainter({
    required this.geo,
    required this.anim,
    required this.transform,
    required this.selected,
    required this.names,
  }) : super(repaint: Listenable.merge([anim, transform]));

  final _MapGeometry geo;
  final Animation<double> anim;
  final TransformationController transform;
  final int? selected;
  final List<String> names;

  @override
  void paint(Canvas canvas, Size size) {
    final t = anim.value; // 0..1 over 60 seconds
    final k =
        1 / transform.value.getMaxScaleOnAxis(); // keeps pins constant size

    // ---- Route to selected pharmacy (follows the streets) ----
    if (selected != null) {
      final target = geo.pharmacies[selected!];
      final route = Path()
        ..moveTo(geo.you.dx, geo.you.dy)
        ..lineTo(target.dx, geo.you.dy)
        ..lineTo(target.dx, target.dy);

      canvas.drawPath(
        route,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 9
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round,
      );
      _drawDashed(
        canvas,
        route,
        Paint()
          ..color = const Color(0xFF1A73E8)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5
          ..strokeCap = StrokeCap.round,
        dash: 14,
        gap: 10,
        phase: ((t * 50) % 1.0) * 24,
      );
    }

    // ---- Cars ----
    final carPaint = Paint();
    final carEdge = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8
      ..color = const Color(0x66000000);
    for (final c in geo.cars) {
      final p = ((c.offset + c.dir * c.speed * t) % 1.0) * _kWorld;
      final lane = c.dir * 3.5;
      final pos = c.horizontal
          ? Offset(p, geo.ys[c.line] + lane)
          : Offset(geo.xs[c.line] + lane, p);
      if (_MapGeometry.inLake(pos)) continue;
      final rect = c.horizontal
          ? Rect.fromCenter(center: pos, width: 10, height: 5.5)
          : Rect.fromCenter(center: pos, width: 5.5, height: 10);
      final rr = RRect.fromRectAndRadius(rect, const Radius.circular(2));
      canvas.drawRRect(rr, carPaint..color = c.color);
      canvas.drawRRect(rr, carEdge);
    }

    // ---- "You are here" ----
    final pulse = (t * 30) % 1.0;
    canvas.drawCircle(
      geo.you,
      (8 + 34 * pulse) * k,
      Paint()..color = const Color(0xFF1A73E8).withOpacity(0.30 * (1 - pulse)),
    );
    canvas.drawCircle(geo.you, 9 * k, Paint()..color = Colors.white);
    canvas.drawCircle(geo.you, 6 * k, Paint()..color = const Color(0xFF1A73E8));

    // ---- Selected pharmacy pulse ----
    if (selected != null) {
      final p = geo.pharmacies[selected!];
      canvas.drawCircle(
        p,
        (6 + 30 * pulse) * k,
        Paint()..color = Colors.redAccent.withOpacity(0.35 * (1 - pulse)),
      );
    }

    // ---- Pins (selected one on top) ----
    for (int i = 0; i < geo.pharmacies.length; i++) {
      if (i == selected) continue;
      _drawPin(canvas, geo.pharmacies[i], k, const Color(0xFF1565C0), null);
    }
    if (selected != null) {
      _drawPin(
        canvas,
        geo.pharmacies[selected!],
        k * 1.25,
        Colors.redAccent,
        selected! < names.length ? names[selected!] : null,
      );
    }
  }

  void _drawPin(
    Canvas canvas,
    Offset p,
    double scale,
    Color color,
    String? label,
  ) {
    canvas.save();
    canvas.translate(p.dx, p.dy);
    canvas.scale(scale);

    // Ground shadow
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: 18, height: 7),
      Paint()..color = Colors.black26,
    );

    // Teardrop body
    final body = Path()
      ..addOval(Rect.fromCircle(center: const Offset(0, -26), radius: 13))
      ..moveTo(-10, -17)
      ..lineTo(0, 0)
      ..lineTo(10, -17)
      ..close();
    canvas.drawPath(
      body,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5
        ..strokeJoin = StrokeJoin.round,
    );
    canvas.drawPath(body, Paint()..color = color);

    // White badge with a plus sign
    canvas.drawCircle(const Offset(0, -26), 8, Paint()..color = Colors.white);
    final plus = Paint()..color = color;
    canvas.drawRect(
      Rect.fromCenter(center: const Offset(0, -26), width: 10, height: 3.2),
      plus,
    );
    canvas.drawRect(
      Rect.fromCenter(center: const Offset(0, -26), width: 3.2, height: 10),
      plus,
    );

    // Name bubble
    if (label != null) {
      final tp = TextPainter(
        text: TextSpan(
          text: label,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
        maxLines: 1,
        ellipsis: '…',
      )..layout(maxWidth: 180);
      final bw = tp.width + 20;
      final bh = tp.height + 12;
      final rr = RRect.fromRectAndRadius(
        Rect.fromLTWH(-bw / 2, -52 - bh, bw, bh),
        const Radius.circular(10),
      );
      canvas.drawShadow(Path()..addRRect(rr), Colors.black, 4, true);
      canvas.drawRRect(rr, Paint()..color = Colors.white);
      tp.paint(canvas, Offset(-tp.width / 2, -52 - bh + 6));
    }

    canvas.restore();
  }

  void _drawDashed(
    Canvas canvas,
    Path path,
    Paint paint, {
    required double dash,
    required double gap,
    required double phase,
  }) {
    for (final m in path.computeMetrics()) {
      double d = phase - (dash + gap);
      while (d < m.length) {
        final s = d.clamp(0.0, m.length).toDouble();
        final e = (d + dash).clamp(0.0, m.length).toDouble();
        if (e > s) canvas.drawPath(m.extractPath(s, e), paint);
        d += dash + gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _LivePainter old) => old.selected != selected;
}
