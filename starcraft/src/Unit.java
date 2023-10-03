public class Unit {
    protected String name;
    protected int offense;
    protected int defense;


    protected boolean flyable;

    public Unit(String name, int offense, int defense,boolean flyable) {
        this.name = name;
        this.offense = offense;
        this.defense = defense;

        this.flyable=flyable;
    }

    public boolean live(){
        if(defense<0)
            return false;
        return true;

    }
}
