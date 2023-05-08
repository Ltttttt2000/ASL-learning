package appendix_b;

import java.util.ArrayList;
import java.util.Collection;

import io.javalin.Javalin;
import jason.asSyntax.ASSyntax;
import jason.asSyntax.Literal;
import jason.environment.Environment;

public class MyEnvironment3 extends Environment {

    @Override
    public void init(String[] args) {
        Javalin app = Javalin.create().start(7070);

        app.post("/percepts/add/:agent", ctx -> {
            String agent = ctx.pathParam("agent");
            Literal percept = ASSyntax.parseLiteral(ctx.body());
            this.addPercept(agent, percept);
        });

        app.post("/percepts/add", ctx -> {
            Literal percept = ASSyntax.parseLiteral(ctx.body());
            this.addPercept(percept);
        });

        app.get("/percepts/:agent", ctx -> {
            String agent = ctx.pathParam("agent");
            Collection<Literal> percepts = this.consultPercepts(agent);
            if (percepts == null) {
                percepts = new ArrayList<Literal>();
            }
            ctx.result(percepts.toString());
        });

        app.post("/percepts/remove/:agent", ctx -> {
            String agent = ctx.pathParam("agent");
            Literal percept = ASSyntax.parseLiteral(ctx.body());
            this.removePercept(agent, percept);
        });

        app.post("/percepts/remove", ctx -> {
            Literal percept = ASSyntax.parseLiteral(ctx.body());
            this.removePercept(percept);
        });

        app.post("/percepts/clear/:agent", ctx -> {
            String agent = ctx.pathParam("agent");
            this.clearPercepts(agent);
        });

        app.post("/percepts/clear", ctx -> {
            this.clearPercepts();
        });
    }

}