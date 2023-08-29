public class DiceCalculator {

    private DiceCalculator(){

    }

    public static int addDice(Dice first, Dice second) {
        return first.getNumber()+second.getNumber();
    }

    public static String getIndexOf(String str,int index) {
        return str.substring(0,index+1);
    }

    public static boolean odd(Dice dice){
        return dice.getNumber()%2!=0;
    }
}
