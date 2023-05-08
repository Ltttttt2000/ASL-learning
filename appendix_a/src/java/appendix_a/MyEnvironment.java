package appendix_a;

import jason.asSyntax.ASSyntax;
import jason.asSyntax.parser.ParseException;
import jason.environment.Environment;

public class MyEnvironment extends Environment {

    @Override
    public void init(String[] args) {
        try {
        	// defined individually for each agent 
            this.addPercept("bob", ASSyntax.parseLiteral("weather(temperature, cold)"));
            // Shared percepts
            this.addPercept(ASSyntax.parseLiteral("weather(cloud_cover, sunny)"));
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

}
