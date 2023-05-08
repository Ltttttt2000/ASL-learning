package appendix_a;

import jason.asSyntax.ASSyntax;
import jason.asSyntax.Literal;
import jason.asSyntax.Structure;
import jason.asSyntax.parser.ParseException;
import jason.environment.Environment;

public class MyEnvironment4 extends Environment {

    @Override
    public void init(String[] args) {
        try {
            this.addPercept("bob", ASSyntax.parseLiteral("weather(temperature, cold)"));
            this.addPercept(ASSyntax.parseLiteral("weather(cloud_cover, sunny)"));

            this.addPercept(ASSyntax.parseLiteral("location(alice, home)"));
            this.addPercept(ASSyntax.parseLiteral("location(bob, work)"));
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

    @Override
    public boolean executeAction(String agentName, Structure environmentAction) {
        System.out.println(this.consultPercepts(agentName));
        try {
            String functor = environmentAction.getFunctor();
            if ( ( functor.equals("walk") || functor.equals("drive") ) && environmentAction.getArity() == 2 ) {
                System.out.println("> " + agentName + " is executing environment action " + environmentAction);
                System.out.println(this.consultPercepts(agentName));
                Literal locationBefore = ASSyntax.parseLiteral("location(" + agentName + ", " + environmentAction.getTerm(0) + ")");
                if (!this.consultPercepts(agentName).contains(locationBefore)) {
                    return false;
                }
                this.removePercept(locationBefore);
                this.addPercept(ASSyntax.parseLiteral("location(" + agentName + ", " + environmentAction.getTerm(1) + ")"));
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