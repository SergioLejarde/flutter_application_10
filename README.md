**Lista de requerimientos del examen y su cumplimiento:**  

📌 **🔹 SERVICIO (BACKEND) - 20 PUNTOS**  
1️⃣ **Debe contar con una base de datos relacional (PostgreSQL) para almacenar usuarios, artículos y artículos favoritos.** ✅ **Cumplido**  
2️⃣ **El servicio debe entregar un JWT al iniciar sesión exitosamente.** ✅ **Cumplido**  
3️⃣ **Cada solicitud de la aplicación al servicio debe incluir el JWT, y este debe ser validado.** ✅ **Cumplido**  

📌 **🔹 APLICACIÓN MÓVIL (FLUTTER) - 30 PUNTOS**  
4️⃣ **Debe contar con una vista para el inicio de sesión.** ✅ **Cumplido**  
5️⃣ **La sesión se debe mantener por 7 días con `SharedPreferences`.** 🔴 **No cumplido completamente (persistencia aún falla a veces).**  
6️⃣ **La aplicación debe utilizar SQLite para almacenar los favoritos.** 🔴 **Problemas con la persistencia en SQLite (se intentó corregir pero no se confirmó que funcione).**  
7️⃣ **Debe tener un mecanismo para cerrar sesión eliminando los datos del usuario.** ✅ **Cumplido**  
8️⃣ **Debe contar con una vista para la lista de artículos, con botón para añadir a favoritos.** ✅ **Cumplido**  
9️⃣ **Debe permitir cambiar entre vista de lista y vista de cuadrícula.** ✅ **Cumplido**  
🔟 **Debe contar con una vista para listar los artículos favoritos.** ✅ **Cumplido**  
1️⃣1️⃣ **Debe permitir quitar elementos de favoritos con el mismo botón.** 🔴 **No se confirmó si funciona correctamente tras reiniciar la app.**  

📌 **🔹 DETALLES ADICIONALES:**  
1️⃣ **Los favoritos no se reflejan inmediatamente en la UI tras agregarlos.** 🔴 **(Falla en la sincronización en `FavoritesProvider`).**  
2️⃣ **La persistencia de la sesión tiene fallos ocasionales.** 🔴 **(A veces la app inicia en login aunque no debería).**  

---

## 🔥 **📌 CONCLUSIÓN FINAL**
- **Backend completo y funcional** ✅  
- **La app en Flutter cumple con casi todo**, pero **falla la persistencia en SQLite y la sincronización de favoritos** 🔴  
