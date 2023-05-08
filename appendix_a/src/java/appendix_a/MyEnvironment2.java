package appendix_a;

import jason.asSyntax.ASSyntax;
import jason.asSyntax.Structure;
import jason.asSyntax.parser.ParseException;
import jason.environment.Environment;

public class MyEnvironment2 extends Environment {

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
        System.out.println("> " + agentName + " is executing functor " + environmentAction.getFunctor() + " applied to terms " + environmentAction.getTerms());
        return true;
    }
    // getFunctor(): function name: walk/drive
    // getTerms(): [Location, Destination] [work, class] [home, class]

}