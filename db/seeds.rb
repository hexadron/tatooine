# encoding: utf-8

basico = Level.create({name: "Básico", position: 1})
intermedio = Level.create({name: "Intermedio", position: 2})
avanzado = Level.create({name: "Avanzado", position: 3})

manuel = User.create({
  first_name: "Manuel",
  last_name: "Eguiluz",
  email: "manuel@example.com",
  password: "password",
  password_confirmation: "password"
})

hoss = User.create({
  first_name: "Hoss",
  last_name: "Fernández",
  email: "hoss@example.com",
  password: "password",
  password_confirmation: "password"
})

julio = User.create({
  first_name: "Julio",
  last_name: "García",
  email: "julio@example.com",
  password: "password",
  password_confirmation: "password"
})

milton = User.create({
  first_name: "Milton",
  last_name: "Chumacero",
  email: "milton@example.com",
  password: "password",
  password_confirmation: "password"
})

lidia = User.create({
  first_name: "Lidia",
  last_name: "Cuchi",
  email: "cuchi_cuchi@example.com",
  password: "password",
  password_confirmation: "password"
})

damaso = User.create({
  first_name: "Dámaso",
  last_name: "López",
  password: "password",
  password_confirmation: "password"
})

mate_basica = Course.create({
  name: "Matemática Básica",
  available_at: DateTime.now,
  description: "Curso de Matemática para dummies",
  level_id: basico.id,
  creator_id: hoss.id
})

teoria_cuantica_1 = Course.create({
  name: "Teoría Cuántica",
  available_at: 7.days.from_now,
  description: "Quema tu cerebro!!",
  level_id: avanzado.id,
  creator_id: manuel.id
})

daw_2 = Course.create({
  name: "Desarrollo de Aplicaciones Web 2",
  available_at: DateTime.now,
  description: "No le hagan caso al profe",
  level_id: intermedio.id,
  creator_id: hoss.id
})

base_de_datos_1 = Course.create({
  name: "Base de Datos 1",
  available_at: 1.week.from_now,
  description: "No lo lleves con Lidia",
  level_id: basico.id,
  creator_id: lidia.id
})

base_de_datos_2 = Course.create({
  name: "Base de Datos 2",
  available_at: 1.week.from_now,
  description: ":D",
  level_id: basico.id,
  creator_id: damaso.id
})