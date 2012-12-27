require 'ostruct'

class Exercise < ActiveRecord::Base
  
  # Solver: Instancia de la clase que manipula el ejercicio
  # Context: Hashmap con la información que se le pasa al solver
  attr_accessor :context, :solver
  
  belongs_to :exercise_type
  belongs_to :section
  
  # Inicializa el contexto al iniciar el objeto.
  after_initialize :create_empty_context
  
  # Filtro... ver método sync_definitions
  before_save :sync_definitions
  
  # Formulario de pregunta. Sólo un string con el nombre del partial
  # a usar, a partir del exercise_type.
  def question_form(type='html')
    if type.to_s == 'html'
      exercise_type.question_partial
    end
  end
  
  # Formulario de respuesta. Nombre del partial a usar
  def answer_form(type='html')
    if type.to_s == 'html'
      exercise_type.answer_partial
    end
  end
  
  # Ingresa data al hash de contexto. Carga
  # el contexto si no está cargado
  def define(definitions)
    load_context unless self.context
    self.context = self.context.merge(definitions)
  end
  
  # Nuevo contexto vacío
  def create_empty_context
    self.context = Hash.new
  end
  
  # Errores: proxy para solver#errors
  def mistakes
    if @solver and errors = @solver.errors
      errors
    else
      []
    end
  end
  
  # Invalidaciones: proxy para solver#invalidations
  def invalidations
    if @solver and invalidations = @solver.invalidations
      invalidations
    else
      []
    end
  end
  
  # Solucionar
  # - Recibe un hash de solución
  # - Llena a solver con la información del contexto
  # - Delega a solver la solución del ejercicio enviandole el objeto solución
  # - Devuelve true o false
  def solve_with(solution = Hash.new)
    exercise_type.update_implementor! if exercise_type
    if exercise_type and @solver = exercise_type.implementor_instance
      load_context if context.empty?
      
      solver.fill(self.context)
      solver.solve_exercise(solution)
    end
  end
  
  # Carga el contexto desde la base de datos,
  # donde éste está serializado como JSON.
  def load_context
    if self.data and self.context.empty?
      decoded = ActiveSupport::JSON.decode self.data
      
      # Transformamos los hashes de STRING => OTHER to
      # SYMBOL => OTHER.
      self.context = decoded.inject({}) do |h, (k, v)|
        h[k.to_sym] = v
        h
      end
    end
  end
  
  # Sincroniza las definiciones del contexto en el atributo data,
  # que será guardado en la base de datos. Serializa el objeto
  # como JSON.
  def sync_definitions
    load_context unless context
    if context
      serialized_context = ActiveSupport::JSON.encode(context)
      self.data = serialized_context
      self
    end
  end
  
  # Representación del contexto en un struct.
  def question_data
    hash_to_struct context
  end
  
  # Representación de la data de respuesta.
  def answer_data
    Hash.new
  end
  
  private
  
  def hash_to_struct(hash)
    o = OpenStruct.new
    hash.each do |k, v|
      o.send("#{k}=", v)
    end
    o
  end
end
