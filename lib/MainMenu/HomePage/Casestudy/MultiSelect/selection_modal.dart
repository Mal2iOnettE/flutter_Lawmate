import 'package:flutter/material.dart';

class SelectionModal extends StatefulWidget {
  @override
  _SelectionModalState createState() => _SelectionModalState();

  final List dataSource;
  final List values;
  final bool filterable;
  final String textField;
  final String valueField;
  final String title;
  final int maxLength;

  SelectionModal(
      {this.filterable,
      this.dataSource,
      this.title = 'Please select one or more option(s)',
      this.values,
      this.textField,
      this.valueField,
      this.maxLength})
      : super();
}

class _SelectionModalState extends State<SelectionModal> {
  Icon icon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  final globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  bool _isSearching;

  List _localDataSourceWithState = [];
  List _searchresult = [];

  _SelectionModalState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
        });
      } else {
        setState(() {
          _isSearching = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    widget.dataSource.forEach((item) {
      var newItem = {
        'value': item[widget.valueField],
        'text': item[widget.textField],
        'checked': widget.values.contains(item[widget.valueField])
      };
      _localDataSourceWithState.add(newItem);
    });

    _searchresult = List.from(_localDataSourceWithState);
    _isSearching = false;
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: Container(),
      backgroundColor: Color(0xFF010037),
      elevation: 0.0,
      title: Text("ค้นหา", style: TextStyle(fontSize: 30.0)),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.close,
            size: 26.0,
          ),
          onPressed: () {
            Navigator.pop(context, null);
          },
        ),
        
      ],
      
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          widget.filterable ? _buildSearchText() : new SizedBox(),
          Expanded(
            child: _optionsList(),
          ),
          _currentlySelectedOptions(),

          ////Bottom tab
          Container(
            color: Colors.white,
            child: ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                ///Button Cancel
                  ButtonTheme(
                    height: 50.0,
                    child: RaisedButton.icon(
                      shape: RoundedRectangleBorder(
                        borderRadius:  new BorderRadius.circular(8.0)
                      ),
                      label: Text('Cancel'),
                      icon: Icon(
                        Icons.clear,
                        size: 20.0,
                      ),
                      color: Colors.grey.shade100,
                      onPressed: () {
                        Navigator.pop(context, null);
                      },
                    ),
                  ),

                  ////Button DONE
                  ButtonTheme(
                    height: 50.0,
                    child: RaisedButton.icon(
                      shape: RoundedRectangleBorder(
                        borderRadius:  new BorderRadius.circular(10.0)
                      ),
                      label: Text('DONE'),
                      icon: Icon(
                        Icons.done,
                        size: 20.0,
                      ),
                      color: Colors.green[300],
                      textColor: Colors.white,
                      onPressed: _localDataSourceWithState
                                  .where((item) => item['checked'])
                                  .length > widget.maxLength
                          ? null
                          : () {
                              var selectedValuesObjectList = _localDataSourceWithState
                                      .where((item) => item['checked'])
                                      .toList();
                              dynamic selectedValues = [];
                              selectedValuesObjectList.forEach((item) {
                                selectedValues.add(item['value']);
                              });
                              Navigator.pop(context, selectedValues);
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => ShowCivilLaw(code: selectedValues,)));
                             // Navigator.push(context, MaterialPageRoute(builder: (context) => ShowSearchData(code: selectedValues,)));
                            },
                    ),
                  )
                ]),
          )
        ],
      ),
    );
  }

  Widget _currentlySelectedOptions() {
    List<Widget> selectedOptions = [];

    var selectedValuesObjectList =
        _localDataSourceWithState.where((item) => item['checked']).toList();
    var selectedValues = [];
    selectedValuesObjectList.forEach((item) {
      selectedValues.add(item['value']);
    });
    selectedValues.forEach((item) {
      var existingItem = _localDataSourceWithState
          .singleWhere((itm) => itm['value'] == item, orElse: () => null);
      selectedOptions.add(
        Chip(
          label: new Container(
            constraints: new BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 80.0),
          child: 
          Text(
            existingItem['text'],
            overflow: TextOverflow.ellipsis
          ),
        ),
        backgroundColor: Colors.amber,
        deleteButtonTooltipMessage: 'Tap to delete this item',
        deleteIcon: Icon(Icons.cancel),
        deleteIconColor: Color(0xFF010037),
        onDeleted: () {
          existingItem['checked'] = false;
          setState(() {});
        },
      ));
    });
    return selectedOptions.length > 0
        ? Container(
            padding: EdgeInsets.all(10.0),
            color: Colors.grey.shade300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new Text(
                  'Currently selected ${selectedOptions.length} items (tap to remove)', // use languageService here
                  style: TextStyle(
                      color: Colors.black87, fontWeight: FontWeight.bold),
                ),
                ConstrainedBox(
                    constraints: new BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height / 8,
                    ),
                    child: Scrollbar(
                      child: SingleChildScrollView(
                          child: Wrap(
                        spacing: 8.0, // gap between adjacent chips
                        runSpacing: 0.4, // gap between lines
                        alignment: WrapAlignment.start,
                        children: selectedOptions,
                      )),
                    )),
              ],
            ),
          )
        : new Container();
  }

  ListView _optionsList() {
    List<Widget> options = [];
    _searchresult.forEach((item) {
      options.add(
        ListTile(
          title: Text(item['text'] ?? ''),
          leading: Transform.scale(
            child: Icon(
                item['checked'] ? Icons.check_circle : Icons.panorama_fish_eye,
                color: Color(0xFF010037)),
            scale: 1.5,
          ),
          onTap: () {
            item['checked'] = !item['checked'];
            setState(() {});
          }));
      options.add(new Divider(height: 1.0));
    });
    return ListView(children: options);
  }

  Widget _buildSearchText() {
    return Container(
      color: Color(0xFF010037), //Theme.of(context).primaryColor,
      padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: TextField(
              controller: _controller,
              keyboardAppearance: Brightness.light,
              onChanged: searchOperation,
              decoration: new InputDecoration(
                  contentPadding: EdgeInsets.all(12.0),
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(6.0),
                    ),
                  ),
                  filled: true,
                  hintText: "ค้นหา...",
                  fillColor: Colors.white,
                  suffix: SizedBox(
                      height: 25.0,
                      child: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                          searchOperation('');
                        },
                        padding: EdgeInsets.all(0.0),
                        tooltip: 'Clear',
                      ))),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: new Scaffold(
        key: globalKey,
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      ),
    );
  }

  void searchOperation(String searchText) {
    _searchresult.clear();
    if (_isSearching != null &&
        searchText != null &&
        searchText.toString().trim() != '') {
      for (int i = 0; i < _localDataSourceWithState.length; i++) {
        String data =
            '${_localDataSourceWithState[i]['value']} ${_localDataSourceWithState[i]['text']}';
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          _searchresult.add(_localDataSourceWithState[i]);
        }
      }
    } else {
      _searchresult = List.from(_localDataSourceWithState);
    }
  }
}
