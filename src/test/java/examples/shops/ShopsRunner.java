package examples.shops;

import com.intuit.karate.junit5.Karate;

class ShopsRunner {
    
    @Karate.Test
    Karate testUsers() {
        return Karate.run("shops").relativeTo(getClass());
    }

    @Karate.Test
    Karate testEmployeeShop() {
        return Karate.run("employee_shop").relativeTo(getClass());
    }

    @Karate.Test
    Karate testAll() {
        return Karate.run().relativeTo(getClass());
    }

}
