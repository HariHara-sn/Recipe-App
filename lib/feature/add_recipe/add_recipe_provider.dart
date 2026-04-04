import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/datasources/add_recipe_firebase_datasource.dart';
import 'data/repositories/add_recipe_repository_impl.dart';
import 'presentation/bloc/add_recipe_bloc.dart';
import 'presentation/pages/add_recipe_page.dart';

class AddRecipeProvider extends StatelessWidget {
  const AddRecipeProvider({super.key});

  @override
  Widget build(BuildContext context) {
    final addrecipeDatasource = AddRecipeFirebaseDatasource();
    final addrecipeRepository = AddRecipeRepositoryImpl(datasource: addrecipeDatasource);
    
    return RepositoryProvider(
      create: (_) => addrecipeRepository,
      child: BlocProvider(
        create: (context) => AddRecipeBloc(
          repository: context.read<AddRecipeRepositoryImpl>(),
        ),
        child: const AddRecipePage(),
      ),
    );
  }
}
