@restresource(urlMapping='/Account/*')
global class DataForConnectedOrg {

    @httpget
    
    global static List<Account> getAccountData()
    {
        return[select id from Account limit 10];
    }
}