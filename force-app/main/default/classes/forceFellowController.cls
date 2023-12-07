public class forceFellowController {
    
    @AuraEnabled(cacheable=true)
    public static string showResult(String name)
    {
        return name + '--xxx';
    }

}