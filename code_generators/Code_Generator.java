
public class Code_Generator{
    public static String ternary_operator(String lang,String a,String b,String c){
        if(new ArrayList<>(Arrays.asList("java")).contains(lang)){
            return "(" + a + "?" + b + ":" + c + ")";
        }
    }
}
