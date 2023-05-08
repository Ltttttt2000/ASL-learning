package appendix_b;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.DefaultListModel;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextField;

import jason.asSyntax.ASSyntax;
import jason.asSyntax.Literal;
import jason.asSyntax.parser.ParseException;

public class MyWindow {

    MyEnvironment2 myEnv;
    String[] myAgents;

    JComboBox<String> agentComboBox;
    DefaultListModel<Literal> perceptListModel;
    JList<Literal> perceptList;
    JTextField addTextfield;

    public MyWindow(MyEnvironment2 env, String[] agents) {
        myEnv = env;
        myAgents = agents;

        agentComboBox = new JComboBox<String>(myAgents);
        agentComboBox.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                @SuppressWarnings("unchecked")
                JComboBox<String> eComboBox = (JComboBox<String>) e.getSource();
                String agent = (String) eComboBox.getSelectedItem();
                refreshPerceptList(agent);  // Refresh the scroll pane whenever the user interacts with the combo box
            }
        });

        perceptListModel = new DefaultListModel<Literal>();
        String agent = (String) agentComboBox.getSelectedItem();
        refreshPerceptList(agent);

        perceptList = new JList<Literal>(perceptListModel);
        perceptList.setVisibleRowCount(4);

        addTextfield = new JTextField("my_percept(1)", 15);

        JButton addAgentButton = new JButton("Add (agent)");
        addAgentButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                try {
                    String agent = (String) agentComboBox.getSelectedItem();
                    Literal percept = ASSyntax.parseLiteral(addTextfield.getText());
                    percept.addAnnot(ASSyntax.parseTerm("scope(agent)"));  // Add custom annotation to explicitly identify percepts in the GUI
                    myEnv.addPercept(agent, percept);  // Add percept for the selected agent
                    refreshPerceptList(agent);
                } catch (ParseException e1) {
                    e1.printStackTrace();
                }
            }
        });

        JButton addSharedButton = new JButton("Add (shared)");
        addSharedButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                try {
                    String agent = (String) agentComboBox.getSelectedItem();
                    Literal percept = ASSyntax.parseLiteral(addTextfield.getText());
                    percept.addAnnot(ASSyntax.parseTerm("scope(shared)"));  // Add custom annotation to explicitly identify shared percepts in the GUI
                    myEnv.addPercept(percept);  // Add shared percept
                    refreshPerceptList(agent);
                } catch (ParseException e1) {
                    e1.printStackTrace();
                }
            }
        });

        JButton removeButton = new JButton("Remove");
        removeButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                if (!perceptList.isSelectionEmpty()) {
                    String agent = (String) agentComboBox.getSelectedItem();
                    Literal percept = (Literal) perceptList.getSelectedValue();
                    String scope = percept.getAnnot("scope").getTerm(0).toString();  // Retrieve the custom annotation to determine what method to call
                    if (scope.equals("agent")) {
                        myEnv.removePercept(agent, percept);  // Remove percept for the selected agent
                    } else {
                        myEnv.removePercept(percept);  // Remove shared percept
                    }
                    refreshPerceptList(agent);
                }
            }
        });

        JButton clearAgentButton = new JButton("Clear (agent)");
        clearAgentButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                String agent = (String) agentComboBox.getSelectedItem();
                myEnv.clearPercepts(agent);  // Clear percepts for the selected agent
                refreshPerceptList(agent);
            }
        });

        JButton clearSharedButton = new JButton("Clear (shared)");
        clearSharedButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                String agent = (String) agentComboBox.getSelectedItem();
                myEnv.clearPercepts();  // Clear shared percepts
                refreshPerceptList(agent);
            }
        });

        JPanel panel = new JPanel();
        panel.add(new JLabel("Agent"));
        panel.add(agentComboBox);
        panel.add(new JLabel("Percept"));
        panel.add(addTextfield);
        panel.add(addAgentButton);
        panel.add(addSharedButton);
        panel.add(new JScrollPane(perceptList));
        panel.add(removeButton);
        panel.add(clearAgentButton);
        panel.add(clearSharedButton);

        JFrame frame = new JFrame("Percept manager");
        frame.getContentPane().add(panel);
        frame.pack();
        frame.setVisible(true);
    }

    /*
     * Refresh contents of the scroll pane based on the selected agent
     */
    private void refreshPerceptList(String agent) {
        perceptListModel.removeAllElements();
        for (Literal p : myEnv.consultPercepts(agent)) {
            perceptListModel.addElement(p);
        }
    }

}