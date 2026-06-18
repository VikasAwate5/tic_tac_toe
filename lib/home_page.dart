import 'package:flutter/material.dart';

import 'common/color_constants.dart';
import 'common/dimens_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool oTurn = true;
  List<String> displayElement = ['', '', '', '', '', '', '', '', ''];
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  // Track winning cells for highlight
  List<int> _winningCells = [];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: DimensConstants.pulseAnimationDuration,
    )..repeat(reverse: true);
    _pulseAnimation =
        Tween<double>(
          begin: DimensConstants.pulseScaleStart,
          end: DimensConstants.pulseScaleEnd,
        ).animate(
          CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
        );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ColorConstants.backgroundStart,
              ColorConstants.backgroundMiddle,
              ColorConstants.backgroundEnd,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ── Title ──────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: DimensConstants.titleVerticalPadding,
                ),
                child: Text(
                  'Tic Tac Toe',
                  style: TextStyle(
                    fontSize: size.width * DimensConstants.titleFontFactor,
                    fontWeight: FontWeight.w900,
                    color: ColorConstants.white,
                    letterSpacing: DimensConstants.titleLetterSpacing,
                    shadows: const [
                      Shadow(
                        color: ColorConstants.primaryPurple,
                        blurRadius: DimensConstants.titleShadowBlur,
                        offset: Offset(0, DimensConstants.titleShadowOffsetY),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Score Board ───────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimensConstants.scoreHorizontalPadding,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildScoreCard(
                        'Player X',
                        xScore,
                        ColorConstants.playerX,
                      ),
                    ),
                    const SizedBox(width: DimensConstants.scoreCardGap),
                    Expanded(
                      child: _buildScoreCard(
                        'Player O',
                        oScore,
                        ColorConstants.playerO,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: DimensConstants.sectionSpacingSmall),

              // ── Turn Indicator ────────────────────────────────────
              ScaleTransition(
                scale: _pulseAnimation,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DimensConstants.turnIndicatorHorizontalPadding,
                    vertical: DimensConstants.turnIndicatorVerticalPadding,
                  ),
                  decoration: BoxDecoration(
                    color:
                        (oTurn
                                ? ColorConstants.playerO
                                : ColorConstants.playerX)
                            .withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(
                      DimensConstants.turnIndicatorRadius,
                    ),
                    border: Border.all(
                      color: oTurn
                          ? ColorConstants.playerO
                          : ColorConstants.playerX,
                      width: DimensConstants.turnIndicatorBorderWidth,
                    ),
                  ),
                  child: Text(
                    oTurn ? "Player O's Turn" : "Player X's Turn",
                    style: TextStyle(
                      fontSize:
                          size.width * DimensConstants.turnIndicatorFontFactor,
                      fontWeight: FontWeight.bold,
                      color: oTurn
                          ? ColorConstants.playerO
                          : ColorConstants.playerX,
                      letterSpacing: DimensConstants.turnIndicatorLetterSpacing,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: DimensConstants.sectionSpacingMedium),

              // ── Game Grid ─────────────────────────────────────────
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DimensConstants.boardHorizontalPadding,
                  ),
                  child: AspectRatio(
                    aspectRatio: DimensConstants.boardAspectRatio,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          DimensConstants.boardRadius,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: ColorConstants.primaryPurpleGlow,
                            blurRadius: DimensConstants.boardGlowBlur,
                            spreadRadius: DimensConstants.boardGlowSpread,
                          ),
                        ],
                      ),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: DimensConstants.boardCellCount,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  DimensConstants.boardCrossAxisCount,
                              crossAxisSpacing:
                                  DimensConstants.boardGridSpacing,
                              mainAxisSpacing: DimensConstants.boardGridSpacing,
                            ),
                        itemBuilder: (_, index) => _buildCell(index),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: DimensConstants.sectionSpacingMedium),

              // ── Reset Button ──────────────────────────────────────
              Padding(
                padding: const EdgeInsets.only(
                  bottom: DimensConstants.scoreHorizontalPadding,
                  left: DimensConstants.scoreHorizontalPadding,
                  right: DimensConstants.scoreHorizontalPadding,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _clearScoreBoard,
                    icon: const Icon(
                      Icons.refresh_rounded,
                      color: ColorConstants.white,
                    ),
                    label: const Text(
                      'Reset All',
                      style: TextStyle(
                        fontSize: DimensConstants.actionButtonFontSize,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.white,
                        letterSpacing:
                            DimensConstants.actionButtonLetterSpacing,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.primaryPurple,
                      padding: const EdgeInsets.symmetric(
                        vertical: DimensConstants.actionButtonVerticalPadding,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          DimensConstants.actionButtonRadius,
                        ),
                      ),
                      elevation: DimensConstants.actionButtonElevation,
                      shadowColor: ColorConstants.primaryPurpleShadow,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreCard(String label, int score, Color accent) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: DimensConstants.scoreCardVerticalPadding,
        horizontal: DimensConstants.scoreCardHorizontalPadding,
      ),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(DimensConstants.scoreCardRadius),
        border: Border.all(
          color: accent.withValues(alpha: 0.4),
          width: DimensConstants.scoreCardBorderWidth,
        ),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: DimensConstants.scoreLabelFontSize,
              fontWeight: FontWeight.w600,
              color: accent,
              letterSpacing: DimensConstants.scoreLabelLetterSpacing,
            ),
          ),
          const SizedBox(height: DimensConstants.scoreValueTopSpacing),
          Text(
            '$score',
            style: TextStyle(
              fontSize: DimensConstants.scoreValueFontSize,
              fontWeight: FontWeight.w900,
              color: ColorConstants.white,
              height: DimensConstants.boardAspectRatio,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCell(int index) {
    final value = displayElement[index];
    final isX = value == 'X';
    final isWinning = _winningCells.contains(index);

    Color cellColor = ColorConstants.boardCell;
    Color borderColor = ColorConstants.boardCellBorder;
    if (isWinning) {
      cellColor = isX
          ? ColorConstants.playerX.withValues(alpha: 0.25)
          : ColorConstants.playerO.withValues(alpha: 0.25);
      borderColor = isX ? ColorConstants.playerX : ColorConstants.playerO;
    }

    return GestureDetector(
      onTap: () => _onTapped(index),
      child: AnimatedContainer(
        duration: DimensConstants.cellAnimationDuration,
        decoration: BoxDecoration(
          color: cellColor,
          borderRadius: BorderRadius.circular(DimensConstants.cellRadius),
          border: Border.all(
            color: borderColor,
            width: DimensConstants.cellBorderWidth,
          ),
          boxShadow: isWinning
              ? [
                  BoxShadow(
                    color: borderColor.withValues(alpha: 0.5),
                    blurRadius: DimensConstants.winningCellGlowBlur,
                  ),
                ]
              : [],
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: DimensConstants.markerAnimationDuration,
            transitionBuilder: (child, anim) =>
                ScaleTransition(scale: anim, child: child),
            child: value.isEmpty
                ? const SizedBox.shrink()
                : Text(
                    value,
                    key: ValueKey(value + index.toString()),
                    style: TextStyle(
                      fontSize: DimensConstants.markerFontSize,
                      fontWeight: FontWeight.w900,
                      color: isX
                          ? ColorConstants.playerX
                          : ColorConstants.playerO,
                      shadows: [
                        Shadow(
                          color:
                              (isX
                                      ? ColorConstants.playerX
                                      : ColorConstants.playerO)
                                  .withValues(alpha: 0.6),
                          blurRadius: DimensConstants.markerShadowBlur,
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  void _onTapped(int index) {
    if (displayElement[index] != '') return;
    setState(() {
      if (oTurn) {
        displayElement[index] = 'O';
        oTurn = false;
      } else {
        displayElement[index] = 'X';
        oTurn = true;
      }
      filledBoxes++;
      _checkWinner();
    });
  }

  void _checkWinner() {
    const lines = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // cols
      [0, 4, 8], [2, 4, 6], // diagonals
    ];

    for (final line in lines) {
      final a = line[0], b = line[1], c = line[2];
      if (displayElement[a] != '' &&
          displayElement[a] == displayElement[b] &&
          displayElement[a] == displayElement[c]) {
        _winningCells = [a, b, c];
        _showWinDialog(displayElement[a]);
        return;
      }
    }

    if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showWinDialog(String winner) {
    if (winner == 'O') {
      oScore++;
    } else {
      xScore++;
    }

    final isO = winner == 'O';
    final accent = isO ? ColorConstants.playerO : ColorConstants.playerX;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => Dialog(
        backgroundColor: ColorConstants.transparent,
        child: Container(
          padding: const EdgeInsets.all(DimensConstants.dialogPadding),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [ColorConstants.boardCell, accent.withValues(alpha: 0.3)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(DimensConstants.dialogRadius),
            border: Border.all(
              color: accent,
              width: DimensConstants.dialogBorderWidth,
            ),
            boxShadow: [
              BoxShadow(
                color: accent.withValues(alpha: 0.4),
                blurRadius: DimensConstants.dialogShadowBlur,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '🎉',
                style: TextStyle(fontSize: DimensConstants.dialogEmojiFontSize),
              ),
              const SizedBox(height: DimensConstants.dialogTopSpacing),
              Text(
                'Player $winner Wins!',
                style: TextStyle(
                  fontSize: DimensConstants.dialogTitleFontSize,
                  fontWeight: FontWeight.w900,
                  color: accent,
                ),
              ),
              const SizedBox(height: DimensConstants.dialogBodySpacing),
              Text(
                'Congratulations!',
                style: TextStyle(
                  fontSize: DimensConstants.dialogBodyFontSize,
                  color: ColorConstants.white70,
                ),
              ),
              const SizedBox(height: DimensConstants.dialogActionTopSpacing),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _clearBoard();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accent,
                    padding: const EdgeInsets.symmetric(
                      vertical: DimensConstants.dialogButtonVerticalPadding,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        DimensConstants.dialogButtonRadius,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Play Again',
                    style: TextStyle(
                      fontSize: DimensConstants.dialogBodyFontSize,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDrawDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => Dialog(
        backgroundColor: ColorConstants.transparent,
        child: Container(
          padding: const EdgeInsets.all(DimensConstants.dialogPadding),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                ColorConstants.boardCell,
                ColorConstants.boardCellBorder,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(DimensConstants.dialogRadius),
            border: Border.all(
              color: ColorConstants.primaryPurple,
              width: DimensConstants.dialogBorderWidth,
            ),
            boxShadow: const [
              BoxShadow(
                color: ColorConstants.primaryPurpleGlow,
                blurRadius: DimensConstants.dialogShadowBlur,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '🤝',
                style: TextStyle(fontSize: DimensConstants.dialogEmojiFontSize),
              ),
              const SizedBox(height: DimensConstants.dialogTopSpacing),
              const Text(
                "It's a Draw!",
                style: TextStyle(
                  fontSize: DimensConstants.dialogTitleFontSize,
                  fontWeight: FontWeight.w900,
                  color: ColorConstants.white,
                ),
              ),
              const SizedBox(height: DimensConstants.dialogBodySpacing),
              const Text(
                'Well played by both!',
                style: TextStyle(
                  fontSize: DimensConstants.dialogBodyFontSize,
                  color: ColorConstants.white70,
                ),
              ),
              const SizedBox(height: DimensConstants.dialogActionTopSpacing),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _clearBoard();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.primaryPurple,
                    padding: const EdgeInsets.symmetric(
                      vertical: DimensConstants.dialogButtonVerticalPadding,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        DimensConstants.dialogButtonRadius,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Play Again',
                    style: TextStyle(
                      fontSize: DimensConstants.dialogBodyFontSize,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _clearBoard() {
    setState(() {
      displayElement = ['', '', '', '', '', '', '', '', ''];
      filledBoxes = 0;
      _winningCells = [];
    });
  }

  void _clearScoreBoard() {
    setState(() {
      xScore = 0;
      oScore = 0;
      displayElement = ['', '', '', '', '', '', '', '', ''];
      filledBoxes = 0;
      _winningCells = [];
      oTurn = true;
    });
  }
}
