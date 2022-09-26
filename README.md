# MovieDex

### Приложение для просмотра списков популярных фильмов, сериалов и знаменитостей.

---
Язык: Swift  
UI: SwiftUI  
Архитектура: MVVM  
Зависимости: [CacheAsyncImage](https://github.com/lorenzofiamingo/swiftui-cached-async-image)  
Источник данных: [TheMovieDB](https://www.themoviedb.org/)

---

Пет-проект

На главном экране реализованы:
* выбор типа списка (популярные или топовые) фильмов/сериалов/знаменитостей
* прокручивающаяся сетка карточек, с плавной подзагрузкой новой информации ("бесконечная лента")
* на карточке отображается постер/фото, а также краткая информация (дата выхода и рейтинг)
* возможность добавить в избранное любой элемент, и приложение это запомнит
* <details><summary>Скриншоты (кликабельны)</summary><a href="https://ibb.co/Mkx1xjV"><img src="https://i.ibb.co/Mkx1xjV/Feed-Popular-Movie.png" alt="Feed-Popular-Movie" border="0"></a> <a href="https://ibb.co/Y33HDxJ"><img src="https://i.ibb.co/Y33HDxJ/Feed-Popular-TV.png" alt="Feed-Popular-TV" border="0"></a> <a href="https://ibb.co/68WjxWx"><img src="https://i.ibb.co/68WjxWx/Feed-Popular-Person.png" alt="Feed-Popular-Person" border="0"></a> <a href="https://ibb.co/BjNLqDz"><img src="https://i.ibb.co/BjNLqDz/Feed-TRMovie.png" alt="Feed-TRMovie" border="0"></a> <a href="https://ibb.co/dr6SZGK"><img src="https://i.ibb.co/dr6SZGK/FeedTRTV.png" alt="FeedTRTV" border="0"></a></details>

На экране деталей:
* фоновое изображение, заголовок/имя, постер/фото, и вся доступная информация по фильму/сериалу/знаменисти
* возможность добавить элемент в избранное
* <details><summary>Скриншоты (кликабельны)</summary><a href="https://ibb.co/GPTYj3Z"><img src="https://i.ibb.co/GPTYj3Z/Detailed-Movie.png" alt="Detailed-Movie" border="0"></a> <a href="https://ibb.co/VSB41mJ"><img src="https://i.ibb.co/VSB41mJ/Detailed-TV.png" alt="Detailed-TV" border="0"></a> <a href="https://ibb.co/W29vByk"><img src="https://i.ibb.co/W29vByk/Detailed-Person.png" alt="Detailed-Person" border="0"></a> <a href="https://ibb.co/CPS9d0F"><img src="https://i.ibb.co/CPS9d0F/Detailed-Person2.png" alt="Detailed-Person2" border="0"></a></details>

На экране поиска:
* поиск названию
* <details><summary>Скриншоты (кликабельны)</summary><a href="https://ibb.co/QDZgDym"><img src="https://i.ibb.co/QDZgDym/Search-Cleared.png" alt="Search-Cleared" border="0"></a> <a href="https://ibb.co/r7zzcbT"><img src="https://i.ibb.co/r7zzcbT/Search-Movie.png" alt="Search-Movie" border="0"></a> <a href="https://ibb.co/Qny5ndp"><img src="https://i.ibb.co/Qny5ndp/SearchTV.png" alt="SearchTV" border="0"></a> <a href="https://ibb.co/7C9KVgt"><img src="https://i.ibb.co/7C9KVgt/Search-Person.png" alt="Search-Person" border="0"></a></details>
