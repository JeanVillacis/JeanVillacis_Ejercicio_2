package petstore.user;

import com.intuit.karate.junit5.Karate;

class UserRunner {

    @Karate.Test
    Karate testUserCrud() {
        return Karate.run("user-crud").relativeTo(getClass());
    }

}
