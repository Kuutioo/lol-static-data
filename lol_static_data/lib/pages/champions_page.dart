// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:champions/champions.dart' as champ;

import './champion_detail_page.dart';

class ChampionsPage extends StatefulWidget {
  final List<champ.Champion> _championList;

  const ChampionsPage(this._championList);

  @override
  State<ChampionsPage> createState() => _ChampionsPageState();
}

class _ChampionsPageState extends State<ChampionsPage> {
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text('Champions');

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
      if (_isSelectedMap.values.every((element) => false)) {
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

        /* print('VALUE = FALSE');
          if (filterChampSelectionMap.containsValue(false)) {
            i++;
            if (i >= 6) {
              result = widget._championList;
            }
          }*/
        /*for (var element in widget._championList) {
            if (element.roles.contains((role))) {
              result = widget._championList
                  .where((champion) => champion.roles.contains(role))
                  .toList();
            }
          }*/
        //result.removeWhere((element) => !element.roles.contains(role));
      },
    );

    /*print('Picked role $role');
    if (isSelected) {
      for (var element in _foundChamps) {
        if (element.roles.contains(role)) {
          result = _foundChamps
              .where((champion) => champion.roles.contains(role))
              .toList();
        }
        _filteredChamps = result;
        _previousChamps = _foundChamps;
      }
    } else {
      // _isSelectedList[index] = isSelected;
      //_filterChampRoles(role, true, index);
      /*_filteredChamps = _previousChamps;
      _isSelectedList[index] = isSelected;
      result = _filteredChamps;

      if (_contains_only(_isSelectedList, false)) {
        result = widget._championList;
      }*/
      print('RESULT = _PREVIOUSCHAMPS');
    }*/
    setState(() {
      _foundChamps = result;
    });
    _filteredChamps = _foundChamps;
  }

  bool _contains_only(var _list, bool e) {
    bool isTrue = _list.every(
      (element) => element == e,
    );
    return isTrue;
  }

  void _showRoleSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return Drawer(
          child: Container(
            color: const Color.fromARGB(255, 197, 201, 209),
            child: ListView.builder(
              itemCount: champ.Role.values.length,
              itemBuilder: (context, index) {
                return SwitchListTile(
                  title: Text(
                    champ.Role.values[index].label,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  value: _isSelectedMap[champ.Role.values[index]],
                  onChanged: (newValue) {
                    setState(() {
                      _isSelectedMap[champ.Role.values[index]] = newValue;
                      if (!newValue) {}
                    });

                    setState(() {
                      //_filteredChamps = [];
                      _filterChampRoles(
                          champ.Role.values[index],
                          _isSelectedMap[champ.Role.values[index]],
                          index,
                          _isSelectedMap);
                    });

                    Future.delayed(Duration(milliseconds: 250), () {
                      Navigator.of(context).pop();
                    });
                  },
                );
                // return TextButton(
                // child: Text(
                //   champ.Role.values[index].label,
                //   style: TextStyle(color: Colors.black, fontSize: 20),
                // ),
                //   onPressed: () {
                //     for (var element in _filteredChamps) {
                //       print(element.name);
                //     }
                //     setState(() {
                //       _filteredChamps = [];
                //       _filterChampRoles(champ.Role.values[index]);
                //     });
                //     Navigator.of(context).pop();
                //   },
                // );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 197, 201, 209),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: cusSearchBar,
        elevation: 10,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (cusIcon.icon == Icons.search) {
                  cusIcon = Icon(Icons.cancel);
                  cusSearchBar = TextField(
                    onChanged: (value) {
                      _runFilter(value);
                    },
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search a champion',
                        hintStyle: TextStyle(
                          color: Colors.white60,
                        )),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  );
                } else {
                  cusIcon = Icon(Icons.search);
                  cusSearchBar = Text('Champions');
                }
              });
            },
            icon: cusIcon,
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
                    //key: ValueKey(_foundChamps[index].name),
                    child: IconButton(
                      icon: Image.network(
                        _foundChamps[index].icon.url,
                        fit: BoxFit.cover,
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
                      child: Text(
                        _foundChamps[index].name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
