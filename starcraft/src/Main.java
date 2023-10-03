import java.util.Random;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        Random random = new Random();

        System.out.println("종족을 고르시오: ");
        System.out.println("1.Terran  2.Protos  3.Zergs");

        int userPick = sc.nextInt();
        Unit[] userUnit =null;
        System.out.println("사용자 유닛");

        switch (userPick){
            case 1:
                userUnit = TerranUnit(random);
                break;
            case 2:
                userUnit = ProtosUnit(random);
                break;
            case 3:
                userUnit = ZergsUnit(random);
                break;
        }


        Unit[] computerUnit= null;
        System.out.println("컴퓨터 유닛:");
        int computerPick = random.nextInt(3)+1;
        switch (computerPick){
            case 1:
                computerUnit = TerranUnit(random);
                break;
            case 2:
                computerUnit = ProtosUnit(random);
                break;
            case 3:
                computerUnit = ZergsUnit(random);
                break;
        }



    }

    private static Unit[] TerranUnit(Random random) {
        Unit[] terranUnit = new Unit[5];
        terranUnit[0]=new Terran("Marine",3,10,false);
        terranUnit[1] =new Terran("Tank",7,15,false);
        terranUnit[2]= new Terran("Goliath",5,15,false);
        terranUnit[3]=new  Terran("Wraith",3,10,true);
        terranUnit[4]=new  Terran("Valkyrie",4,12,true);

        Unit[] terranpickUnit = new Unit[5];
        terranpickUnit[0]=terranUnit[random.nextInt(3)];
        terranpickUnit[1]=terranUnit[random.nextInt(3)];
        terranpickUnit[2]=terranUnit[random.nextInt(3)];
        terranpickUnit[3]=terranUnit[random.nextInt(2)+3];
        terranpickUnit[4]=terranUnit[random.nextInt(2)+3];

        for (Unit unit : terranpickUnit){
            System.out.println(unit.name+" "+ unit.offense+" "+ unit.defense+" "+unit.flyable);
        }

        return terranpickUnit;


    }
    private static Unit[] ProtosUnit(Random random) {
        Unit[] protosUnit = new Unit[5];
        protosUnit[0]=new Protos("Zealot",5,20,false);
        protosUnit[1] =new Protos("Dragoon",3,15,false);
        protosUnit[2]= new Protos("HighTempler",10,2,false);
        protosUnit[3]=new Protos("Scout",5,10,true);
        protosUnit[4]=new Protos("Corsair",4,12,true);

        Unit[] protospickUnit = new Unit[5];
        protospickUnit[0]=protosUnit[random.nextInt(3)];
        protospickUnit[1]=protosUnit[random.nextInt(3)];
        protospickUnit[2]=protosUnit[random.nextInt(3)];
        protospickUnit[3]=protosUnit[random.nextInt(2)+3];
        protospickUnit[4]=protosUnit[random.nextInt(2)+3];

        for (Unit unit : protospickUnit){
            System.out.println(unit.name+" "+ unit.offense+" "+ unit.defense+" "+unit.flyable);
        }

        return protosUnit;


    }
    private static Unit[] ZergsUnit(Random random) {
        Unit[] zergUnit = new Unit[5];
        zergUnit[0]=new Zerg("Zergling",2,2,false);
        zergUnit[1] =new Zerg("Hydralisk",3,7,false);
        zergUnit[2]= new Zerg("Ultralisk",5,15,false);
        zergUnit[3]=new Zerg("Mutalisk",2,8,true);
        zergUnit[4]=new Zerg("Guardian",3,6,true);

        Unit[] zergpickUnit = new Unit[4];
        zergpickUnit[0]=zergUnit[random.nextInt(3)];
        zergpickUnit[1]=zergUnit[random.nextInt(3)];
        zergpickUnit[2]=zergUnit[random.nextInt(2)+3];
        zergpickUnit[3]=zergUnit[random.nextInt(2)+3];

        for (Unit unit : zergpickUnit){
            System.out.println(unit.name+" "+ unit.offense+" "+ unit.defense+" "+unit.flyable);
        }

        return zergUnit;


    }
}