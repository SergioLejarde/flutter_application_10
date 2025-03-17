✅ PostgreSQL (Backend)

users: Guarda los datos de los usuarios.
articles: Lista de artículos de brownies.
backend_favorites: Guarda los favoritos, pero no es persistente en Flutter.
✅ SQLite (Flutter App)

sqlite_favorites: Solo guarda favoritos en la app, NO en el backend.
✅ Conexión PostgreSQL → SQLite

Los favoritos se sincronizan con SQLite, pero no se guardan en PostgreSQL.


Explicación de la Sincronización entre PostgreSQL y SQLite
El sistema utiliza dos bases de datos para manejar los artículos y favoritos:

PostgreSQL (Backend):

Es la base de datos principal que almacena a los usuarios, artículos, y favoritos de manera global.
Aquí los favoritos se guardan por usuario, lo que permite que sean accesibles desde cualquier dispositivo.
SQLite (Flutter App):

Es una base de datos local en cada dispositivo, utilizada para mejorar la rapidez y la experiencia del usuario.
Los favoritos solo se almacenan localmente, lo que significa que no se sincronizan automáticamente con el backend.
Proceso de Sincronización
Cuando un usuario marca un artículo como favorito, este se guarda únicamente en SQLite.
Si la aplicación tuviera una opción de sincronización, se podría enviar esta información al backend para mantenerla en PostgreSQL.
Actualmente, los favoritos no se guardan en el backend, sino que se mantienen solo en la app del usuario.
Conclusión
El mensaje del recuadro amarillo deja claro que no hay sincronización automática entre SQLite y PostgreSQL. Es decir, si el usuario cierra sesión o reinstala la app, sus favoritos se perderán, porque solo existían en SQLite.

es como decir : "En futuras versiones, se podría implementar una sincronización automática para guardar los favoritos en PostgreSQL y mantenerlos disponibles en cualquier dispositivo."