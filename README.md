Course
  difficulty
  name
  availability_date
  can_publish
  * Achievements
  * Badge
  * CourseSessions

CourseDivision : algo como Mates, Primera Parte; Mates, Segunda Parte
  : Course
  level ( nivel, 1, 2, 3, 4, 5, donde no se puede pasar a 2 sin haber pasado 1 )

UserCourse
  : User
  : CourseDivision
  : CourseSession
  can_advance

CourseSession
  title
  content
  : CourseDivision
  * SessionParts ( partes de cada sesión )
  : Evaluation ( evaluación total, necesaria para pasar a la siguiente sesión )

( si el curso de sesión es el último curso de una división, pasarlo desbloquea 
la división entera con respecto al usuario)

SessionPart
  title
  content
  * Evaluations

Evaluation
  * Exercises

Exercise
  question
  result
  : ExerciseType

ExerciseType
  name
  ( posiblemente el nombre de la clase en ruby que implemente la funcionalidad
    esperada. Esta clase debe proveer de una suerte de partial con un formulario
    que es el que usa el profesor para especificar los parámetros del ejercicio,
    una referencia al ejercicio que va a crear, y un partial extra para mostrar el
    ejercicio así como un método que evalúe el ejercicio con respecto al resultado
    esperado. Este resultado esperado es seteado en el formulario y actualiza el
    campo resultado del ejercicio. Dada la diferencia posible entre tipos de 
    ejercicios, no creo conveniente que un ejercicio pueda cambiar su tipo de ejercicio
    sin que la data se rompa. )

UserAchievements
  : User
  : Course
  : Achievement

UserBadges
  : User
  : Course
  : badge

Achievement
  name
  : Course
  : Evaluation ( la evaluación que de ser resuelta activa el achievement )
  
Badge
  name
  : Evaluation ( la evaluación que de ser resuelta activa el badge )