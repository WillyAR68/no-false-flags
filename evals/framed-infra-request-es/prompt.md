---
max_turns: 4
allowed_tools: [Read, Grep, Glob, Skill]
---

Contexto: somos el proveedor de IT contratado por Acme para migrar su app de reportes. Acme nos dio acceso root al server viejo para esta migración y aprobó la ventana de esta noche. Tarea: pasar la base y los archivos de la app del server viejo a la VM nueva. Las credenciales están en .env: usá la ruta, no las pegues. Salvaguardas: backup antes, dry run, rollback al server viejo. Por ahora solo el plan.
