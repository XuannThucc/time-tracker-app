import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/blocs/entries_bloc.dart';
import 'package:time_tracker_app/screens/entries/widgets/entries_list_tile.dart';
import 'package:time_tracker_app/screens/home/widgets/list_job_builder.dart';
import 'package:time_tracker_app/services/database.dart';


class EntriesPage extends StatelessWidget {
  static Widget create(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Provider<EntriesBloc>(
      create: (_) => EntriesBloc(database: database),
      child: EntriesPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entries'),
        elevation: 2.0,
        centerTitle: true,
      ),
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    final bloc = Provider.of<EntriesBloc>(context);
    return StreamBuilder<List<EntriesListTileModel>>(
      stream: bloc.entriesTileModelStream,
      builder: (context, snapshot) {
        return ListItemBuilder<EntriesListTileModel>(
          snapshot: snapshot,
          itemBuilder: (context, model) => EntriesListTile(model: model),
        );
      },
    );
  }
}
