import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/datasources/add_recipe_firebase_datasource.dart';
import 'data/repositories/add_recipe_repository_impl.dart';
import 'presentation/bloc/add_recipe_bloc.dart';
import 'presentation/pages/add_recipe_page.dart';

/// Wrap AddRecipePage with its own BLoC + Repository providers.
/// Use this widget when navigating to the add recipe screen.
///
/// Usage:
///   Navigator.push(context, MaterialPageRoute(
///     builder: (_) => const AddRecipeProvider(),
///   ));
class AddRecipeProvider extends StatelessWidget {
  const AddRecipeProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => AddRecipeRepositoryImpl(
        datasource: AddRecipeFirebaseDatasource(),
      ),
      child: BlocProvider(
        create: (context) => AddRecipeBloc(
          repository: context.read<AddRecipeRepositoryImpl>(),
        ),
        child: const AddRecipePage(),
      ),
    );
  }
}
