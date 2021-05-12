require 'simplecov'
SimpleCov.start
require './src/decorator.rb'
require 'minitest/autorun'

class Tester < Minitest::Test
    def test_enemigo_should_return_no_implementado
        e = Enemigo.new
        assert_equal e.recibirDaño, "no implementado"
        assert_equal e.recibirDañoCritico, "no implementado"
    end

    def test_enemigoComun_and_boss_should_return_vida
      e = EnemigoComun.new
      j = Jefe.new
      assert_equal e.vida, 100
      assert_equal j.vida, 200
    end

    def test_Decorators_should_contain_enemies
        e = EnemigoComun.new
        j = Jefe.new
        ce = Casco.new(e)
        cj = Casco.new(j)
        ae = Armadura.new(e)
        aj = Armadura.new(j)
        assert_equal e, ce.objeto
        assert_equal j, cj.objeto
        assert_equal e, ae.objeto
        assert_equal j, aj.objeto
    end

    def test_enemigoComun_and_boss_should_recive_dmg
        e = EnemigoComun.new
        j = Jefe.new
        assert_equal e.recibirDaño(10), 90
        assert_equal j.recibirDaño(10), 195
        assert_equal e.recibirDañoCritico(10), 70
        assert_equal j.recibirDañoCritico(10), 185
      end  

    def test_Armadura_and_casco_should_modify_life_the_same_way_no_matter_the_order
        e1 = EnemigoComun.new
        e2 = EnemigoComun.new
        c1 = Casco.new(e1)
        a1 = Armadura.new(c1)
        a2 = Armadura.new(e2)
        c2 = Casco.new(a2)
        assert_equal a1.recibirDaño(20),c2.recibirDaño(20)
        assert_equal a1.recibirDañoCritico(20),c2.recibirDañoCritico(20)
    end

    def test_Decorator_should_contain_decorators
        e = EnemigoComun.new
        j = Jefe.new
        ce = Casco.new(e)
        ae = Armadura.new(ce)
        aj = Armadura.new(j)
        cj = Casco.new(aj)
        assert_equal ce, ae.objeto
        assert_equal aj, cj.objeto
    end

    def test_Decorator_should_contain_decorators
        e = EnemigoComun.new
        esc = Escudo.new(e)
        assert_equal esc.recibirDañoCritico(50), "ataque bloqueado"
        assert_equal esc.recibirDaño(50), "ataque bloqueado"
        assert_equal esc.recibirDañoCritico(50), "ataque bloqueado"
        assert_equal esc.recibirDaño(50), 50
    end
end