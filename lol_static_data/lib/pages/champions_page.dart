// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:champions/champions.dart' as champ;
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

import '../widgets/hamburger_bar.dart';
import './champion_detail_page.dart';
import '../widgets/detail_text/champion_detail_text.dart';
import '../helpers/gradient_text.dart';

class ChampionsPage extends StatefulWidget {
  static const routeName = 'champions-page';

  final List<champ.Champion> _championList;

  const ChampionsPage(this._championList);

  @override
  State<ChampionsPage> createState() => _ChampionsPageState();
}

class _ChampionsPageState extends State<ChampionsPage> {
  Icon customIcon = Icon(Icons.search);
  Widget customSearchBar = Text(
    'Champions',
    style: TextStyle(color: Colors.white),
  );

  List<champ.Champion> _foundChamps = [];
  List<champ.Champion> _filteredChamps = [];

  final Map<champ.Role, bool> _isSelectedMap = {
    champ.Role.assassin: false,
    champ.Role.fighter: false,
    champ.Role.mage: false,
    champ.Role.marksman: false,
    champ.Role.support: false,
    champ.Role.tank: false,
  };

  @override
  void initState() {
    super.initState();

    _foundChamps = widget._championList;
  }

  void _runFilter(String enteredKeyword) {
    List<champ.Champion> result = [];
    if (enteredKeyword.isEmpty && _isSelectedMap.containsValue(true)) {
      result = _filteredChamps;
    } else if (enteredKeyword.isEmpty) {
      result = widget._championList;
    } else {
      if (_isSelectedMap.values.every((element) => element == false)) {
        result = widget._championList
            .where((champion) => champion.name
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()))
            .toList();
      } else {
        result = _filteredChamps
            .where((champion) => champion.name
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()))
            .toList();
      }
    }
    setState(() {
      _foundChamps = result;
    });
  }

  void _filterChampRoles(
    champ.Role role,
    bool isSelected,
    int index,
    Map<champ.Role, bool> filterChampSelectionMap,
  ) {
    List<champ.Champion> result = [];

    int i = 0;

    filterChampSelectionMap.forEach(
      (key, value) {
        if (value) {
          result = _foundChamps
              .where((champion) => champion.roles.contains(role))
              .toList();
        } else {
          if (filterChampSelectionMap.containsValue(false)) {
            i++;
            if (i >= 6) {
              result = widget._championList;
            }
          }
        }
      },
    );
    setState(() {
      _foundChamps = result;
    });
    _filteredChamps = _foundChamps;
  }

  void _showRoleSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: ((context, setState) {
            return Drawer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: const [
                      Color.fromARGB(255, 47, 69, 76),
                      Color.fromARGB(255, 7, 32, 44),
                    ],
                  ),
                ),
                child: ListView.builder(
                  itemCount: champ.Role.values.length,
                  itemBuilder: (context, index) {
                    return SwitchListTile(
                      activeColor: const Color.fromARGB(255, 206, 167, 29),
                      title: GradientText(
                        champ.Role.values[index].label,
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 171, 150, 76),
                            Color.fromARGB(255, 247, 217, 110),
                          ],
                        ),
                        style: TextStyle(fontSize: 20),
                      ),
                      /*Text(
                        champ.Role.values[index].label,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),*/
                      value: _isSelectedMap[champ.Role.values[index]],
                      onChanged: (newValue) {
                        setState(() {
                          _isSelectedMap[champ.Role.values[index]] = newValue;
                          if (!newValue) {}
                        });
                        setState(() {
                          _filterChampRoles(
                              champ.Role.values[index],
                              _isSelectedMap[champ.Role.values[index]],
                              index,
                              _isSelectedMap);
                        });
                      },
                    );
                  },
                ),
              ),
            );
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(255, 199, 203, 212),
      drawer: HamburgerBar(),
      appBar: NewGradientAppBar(
        gradient: const LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color.fromARGB(255, 47, 69, 76),
            Color.fromARGB(255, 7, 32, 44),
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: customSearchBar,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (customIcon.icon == Icons.search) {
                  customIcon = Icon(Icons.cancel);
                  customSearchBar = TextField(
                    autofocus: true,
                    onChanged: (value) {
                      _runFilter(value);
                    },
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search a champion',
                        hintStyle: TextStyle(
                          color: Colors.white,
                        )),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  );
                } else {
                  customIcon = Icon(Icons.search);
                  customSearchBar = Text(
                    'Champions',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  );
                }
              });
            },
            icon: customIcon,
          ),
          IconButton(
            onPressed: () => _showRoleSheet(context),
            icon: Icon(Icons.filter_alt_rounded),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _filteredChamps = [];
                _isSelectedMap.forEach((key, value) {
                  _isSelectedMap[key] = false;
                });
                _foundChamps = widget._championList;
              });
            },
            tooltip: 'FIX ALL BUGS :)',
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 47, 69, 76),
              Color.fromARGB(255, 7, 32, 44),
            ],
          ),
        ),
        child: _foundChamps.isNotEmpty
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _foundChamps.length,
                itemBuilder: ((context, index) {
                  return GridTile(
                    child: IconButton(
                      icon: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              width: 3,
                              color: Color.fromARGB(
                                255,
                                171,
                                150,
                                76,
                              ),
                            )),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            _foundChamps[index].icon.url,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          ChampionDetailPage.routeName,
                          arguments: _foundChamps[index],
                        );
                      },
                    ),
                    footer: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: ChampionDetailText(
                        _foundChamps[index].name,
                        20,
                        true,
                      ), /*Text(
                        _foundChamps[index].name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),*/
                    ),
                  );
                }),
              )
            : Center(
                child: const Text(
                  'No results found',
                  style: TextStyle(fontSize: 24),
                ),
              ),
      ),
    );
  }
}
