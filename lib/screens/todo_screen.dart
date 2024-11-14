// lib/screens/todo_screen.dart

import 'package:flutter/material.dart';
import 'package:loatodo_app/models/characters/character_model.dart';
import 'package:loatodo_app/services/apis/character_api.dart';
import 'package:loatodo_app/widgets/todo/character_info_widget.dart';
import 'package:loatodo_app/widgets/todo/day_todo_widget.dart';

class TodoScreen extends StatelessWidget {
  TodoScreen({super.key});

  final Future<List<CharacterModel>> characterList =
      CharacterApi.getCharacterList();

  int _getColumnCount(double screenWidth) {
    if (screenWidth > 800) {
      return 4; // 태블릿/데스크톱 레이아웃
    }
    return 2; // 모바일 레이아웃
  }

  Widget _buildCharacterCard(CharacterModel character, double width) {
    return SizedBox(
      width: width,
      child: Column(
        children: [
          CharacterInfoWidget(
            username:
                '@${character.serverName} ${character.characterClassName}',
            characterName: character.characterName,
            level: character.itemLevel,
            memo: character.memo ?? '',
            imageUrl: character.characterImage,
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: DayTodoWidget(
              chaos: character.chaos,
              chaosCheck: character.chaosCheck,
              chaosGauge: character.chaosGauge,
              chaosGold: character.chaosGold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCharacterGrid(
      BuildContext context, List<CharacterModel> characters) {
    final screenWidth = MediaQuery.of(context).size.width;
    final columnCount = _getColumnCount(screenWidth);

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth =
            (constraints.maxWidth - (columnCount - 1) * 5) / columnCount;

        return Wrap(
          spacing: 5,
          runSpacing: 10,
          children: characters
              .map((character) => _buildCharacterCard(character, itemWidth))
              .toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<List<CharacterModel>>(
              future: characterList,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline,
                            color: Colors.red[300], size: 48),
                        const SizedBox(height: 16),
                        Text(
                          'Error: ${snapshot.error}',
                          style: TextStyle(color: Colors.red[300]),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return _buildCharacterGrid(context, snapshot.data!);
              },
            ),
          ),
        ),
      ),
    );
  }
}
