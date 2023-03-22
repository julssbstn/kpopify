import 'package:flutter/material.dart';
import 'package:kpopify/bloc/artist_bloc.dart';
import 'package:kpopify/bloc/bloc_provider.dart';
import 'package:kpopify/components/kpopify_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: ArtistBloc("cc72cd13ca8b4e4c95bf6ad86d93d1c3"),
      child: MaterialApp(
        title: 'Kpopify',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const KpopifyPage(title: 'Kpopify Page'),
      ),
    );
  }
}
