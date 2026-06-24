

import 'package:get_it/get_it.dart';
import 'package:newsly/core/network/dio_client.dart';
import 'package:newsly/features/news/presentation/cubit/category_news_cubit.dart';
import 'package:newsly/features/news/presentation/cubit/news_cubit.dart';

import '../../features/bookmarks/data/bookmark_local_data.dart';
import '../../features/bookmarks/presentation/cubit/bookmark_cubit.dart';
import '../../features/news/data/repositories/news_repository_impl.dart';
import '../../features/news/domain/repositories/news_repository.dart';

final getIt=GetIt.instance;
void setServiceLocator(){
  getIt.registerLazySingleton<DioClient>(()=>DioClient());

  getIt.registerLazySingleton<NewsRepository>(()=>NewsRepositoryImpl(dioClient:getIt()));

  getIt.registerFactory<NewsCubit>(
      (){
        return NewsCubit(newsRepository: getIt());
      }
  );

  getIt.registerCachedFactory<CategoryNewsCubit>(
      (){
        return CategoryNewsCubit(newsRepository: getIt());
      }
  );

  getIt.registerLazySingleton<BookmarkLocalData>(
        () => BookmarkLocalData(),
  );

  getIt.registerFactory<BookmarkCubit>(
        () => BookmarkCubit(localDataSource: getIt()),
  );

}