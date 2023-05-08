package appendix_b;

import jason.environment.Environment;

public class MyEnvironment2 extends Environment {

    @Override
    public void init(String[] args) {
    	String[] agents = {"alice", "bob"};
    	new MyWindow(this, agents);

    }

}