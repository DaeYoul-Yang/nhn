public class Main1 {

    public static void main(String[] args) {
        int random1 =(int)(Math.random()*6)+1;
        int random2 =(int)(Math.random()*6)+1;

        Dice first = new Dice(random1);
        Dice second = new Dice(random1);

        System.out.println("주사위 합 = "+ DiceCalculator.addDice(first,second));

        String str = "absdefg";

        int val =(int)(Math.random()*str.length());
        System.out.println(DiceCalculator.getIndexOf(str,val));

        int random4 = (int)(Math.random()*6)+1;
        Dice dice = new Dice(random4);
        System.out.println("주사위 눈("+random4+")이 홀수: "+DiceCalculator.odd(dice));
    }

//    private static class DiceCalculator {
//        static int addDice(Dice a, Dice b){
//            return a+b;
//
//        }
//
//        static int getIndexOf(int a){
//        }
//
//        static boolean odd(int a){
//            if(a%2==0)
//                return false;
//            return true;
//        }
//
//    }
}
