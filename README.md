para subirlo
git add -A
git commit -m "mensaje"
git push

# Tatooine

## Modelo De Datos

### Estructura De Los Cursos

    | cada Curso
    |   tiene muchas DivisionesDeCurso
    |     cada DivisiónDeCurso
    |       tiene muchas SesionesDeCurso
    | cada Curso
    |   tiene muchas SesionesDeCurso
    |     cada SesiónDeCurso
    |       tiene muchas PartesDeLaSesión
    |         cada ParteDeLaSesión
    |           tiene muchas Evaluaciones
    |     cada SesiónDeCurso
    |       tiene una Evaluación Final
    |         cada Evaluación
    |           tiene muchos Ejercicios
    |             cada Ejercicio
    |               tiene un tipoDeEjercicio
    | cada Curso
    |   tiene muchas medallas desbloqueables
    | cada Curso
    |   tiene muchos logros desbloqueables


### Generadores

    # inscripción
    rails g model enrollment user:references course:references
    # curso (Ej: Historia Universal del Siglo XX)
    rails g model course difficulty name available_at:date can_be_published:boolean
    # división (Ej: Las Guerras Mundiales)
    rails g model division level:integer course:references
    # sesión de curso (Ej: Segunda Guerra Mundial)
    rails g model course_session title content:text division:references course:references
    # parte de una sesión (Ej: Causas de la Segunda Guerra Mundial)
    rails g model session_part title content:text course_session:references 
    # evaluación
    rails g model evaluation session_part:references course_session:references
    # tipos de ejercicios
    rails g model exercise_type name
    # ejercicios
    rails g model exercise question:text result:text exercise_type:references evaluation:references
    # logros
    rails g model achievement course:references evaluation:references name description:text
    # medallas
    rails g model badge name description evaluation:references course:references
  

### Definiciones De Modelos

- Course
  - difficulty
  - name
  - availability_date
  - can_publish
  - * Achievements
  - * Badge
  - * CourseSessions

- CourseDivision : algo como Mates, Primera Parte; Mates, Segunda Parte
  - : Course
  - level ( nivel, 1, 2, 3, 4, 5, donde no se puede pasar a 2 sin haber pasado 1 ) : integer

- Enrollment
  - : User
  - : Course

- CourseSession
  - title
  - content
  - : CourseDivision
  - * SessionParts ( partes de cada sesión )
  - : Evaluation ( evaluación total, necesaria para pasar a la siguiente sesión. Si el curso de sesión es el último curso de una división, pasarlo desbloquea 
la división entera con respecto al usuario)

- SessionPart
  - title
  - content
  - * Evaluations

- Evaluation
  - * Exercises

- ExerciseType
  - name (posiblemente el nombre de la clase en ruby que implemente la funcionalidad esperada. Esta clase debe proveer de una suerte de partial con un formulario que es el que usa el profesor para especificar los parámetros del ejercicio, una referencia al ejercicio que va a crear, y un partial extra para mostrar el ejercicio así como un método que evalúe el ejercicio con respecto al resultado esperado. Este resultado esperado es seteado en el formulario y actualiza el campo resultado del ejercicio. Dada la diferencia posible entre tipos de ejercicios, no creo conveniente que un ejercicio pueda cambiar su tipo de ejercicio sin que la data se rompa. )

- Exercise
  - question
  - result
  -: ExerciseType

- UserAchievements
  -: User
  -: Course
  -: Achievement

- UserBadges
  -: User
  -: Course
  -: badge

- Achievement
  - name
  -: Course
  -: Evaluation ( la evaluación que de ser resuelta activa el achievement )
    
- Badge
  - name
  - imagen (agregar cuando sea necesario usando Paperclip)
  -: Course
  -: Evaluation ( la evaluación que de ser resuelta activa el badge )