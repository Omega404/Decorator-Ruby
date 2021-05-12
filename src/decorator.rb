class Enemigo
  attr_accessor :vida
  def recibirDaño
    "no implementado"
  end

  def recibirDañoCritico
    "no implementado"
  end
end

class EnemigoComun < Enemigo
  def initialize
    @vida = 100
  end
  def recibirDaño(daño)
    @vida -= daño
  end
  def recibirDañoCritico(daño)
    @vida -= daño*2
  end
end

class Jefe < Enemigo
  def initialize
    @vida = 200
  end
  def recibirDaño(daño)
    @vida -= daño/2
  end
  def recibirDañoCritico(daño)
    @vida -= daño
  end
end

class Decorator < Enemigo
  attr_accessor :objeto
  def initialize(obj)
    @objeto =obj
  end

  def recibirDaño(daño)
    @objeto.recibirDaño(daño)
  end

  def recibirDañoCritico(daño)
    @objeto.recibirDañoCritico(daño)
  end
end

class Casco < Decorator
  def recibirDaño(daño)
    @objeto.recibirDaño(daño-10)
  end

  def recibirDañoCritico(daño)
    @objeto.recibirDañoCritico(daño/2)
  end
end

class Armadura < Decorator
  def recibirDaño(daño)
    @objeto.recibirDaño(daño-30)
  end
end

class Escudo < Decorator
  @defensa
  def initialize(enemigo)
    @objeto = enemigo
    @defensa = 3
  end

  def recibirDaño(daño)
    if resistir
      "ataque bloqueado"
    else
      @objeto.recibirDaño(daño)
    end
  end

  def recibirDañoCritico(daño)
    if resistir
      "ataque bloqueado"
    else
      @objeto.recibirDañoCritico(daño)
    end
  end

  def resistir
    @defensa = @defensa - 1
    @defensa >= 0 
  end
end

class Daga < Decorator
  def suicidio
    @objeto
  end
end

e = EnemigoComun.new
ec = Casco.new(e)
ecd = Daga.new(ec)
puts ecd.suicidio