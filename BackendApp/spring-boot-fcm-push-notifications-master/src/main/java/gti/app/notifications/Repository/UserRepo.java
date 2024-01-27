package gti.app.notifications.Repository;

import gti.app.notifications.model.User;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;


@Repository
public interface UserRepo extends JpaRepository<User, Long> {
       User  findByMatricule(String matricule);

       Optional<User> findByFcmtoken(String token);
       @Query(value = "SELECT  * FROM user_tab t WHERE t.matricule =?1 ", nativeQuery = true)
       Optional<User> findBymatricule(String matricule);


}