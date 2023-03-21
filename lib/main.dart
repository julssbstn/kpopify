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
      bloc: ArtistBloc("f2272d59114d411a9729008c769d16a1"),
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
