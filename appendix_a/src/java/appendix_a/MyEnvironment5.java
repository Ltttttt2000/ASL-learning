package appendix_a;

import java.util.HashMap;
import java.util.Map;

import jason.asSyntax.ASSyntax;
import jason.asSyntax.Literal;
import jason.asSyntax.Structure;
import jason.asSyntax.parser.ParseException;
import jason.environment.Environment;

public class MyEnvironment5 extends Environment {

    int DEFAULT_ENERGY = 5;

    Map<String, Integer> energy;

    @Override
    public void init(String[] args) {
        try {
            this.addPercept("bob", ASSyntax.parseLiteral("weather(temperature, cold)"));
            this.addPercept(ASSyntax.parseLiteral("weather(cloud_cover, sunny)"));

            this.addPercept(ASSyntax.parseLiteral("location(alice, home)"));
            this.addPercept(ASSyntax.parseLiteral("location(bob, work)"));

            this.addPercept(ASSyntax.parseLiteral("energy(" + DEFAULT_ENERGY + ")"));

            energy = new HashMap<String, Integer>();
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

    @Override
    public boolean executeAction(String agentName, Structure environmentAction) {
        try {
            String functor = environmentAction.getFunctor();
            if ( ( functor.equals("walk") || functor.equals("drive") ) && environmentAction.getArity() == 2 ) {
                System.out.println("> " + agentName + " is executing environment action " + environmentAction);

                Literal locationBefore = ASSyntax.parseLiteral("location(" + agentName + ", " + environmentAction.getTerm(0) + ")");
                if (!this.consultPercepts(agentName).contains(locationBefore)) {
                    return false;
                }

                int energyBefore = energy.getOrDefault(agentName, DEFAULT_ENERGY);

                this.removePercept(locationBefore);
                this.removePercept(agentName, ASSyntax.parseLiteral("energy(" + energyBefore + ")"));

                int energyCost;
                if (functor.equals("walk")) {
                    energyCost = 3;
                } else {
                    energyCost = 1; 
                }

                int energyAfter = energyBefore - energyCost;
                energy.put(agentName, energyAfter);

                this.addPercept(ASSyntax.parseLiteral("location(" + agentName + ", " + environmentAction.getTerm(1) + ")"));
                this.addPercept(agentName, ASSyntax.parseLiteral("energy(" + energyAfter + ")"));

                return true;
            } else {
                System.err.println("> " + agentName + " is attempting to execute unknown environment action " + environmentAction);
                return false;
            }
        } catch (ParseException e) {
            e.printStackTrace();
            return false;
        }
    }

}