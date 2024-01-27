package gti.app.notifications.controller;

import gti.app.notifications.Repository.UserRepo;
import gti.app.notifications.model.User;
import gti.app.notifications.model.UserResponse;
import gti.app.notifications.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
import java.util.concurrent.ExecutionException;

@Controller
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class UserController {
    @Autowired
    private UserService service;
    @Autowired
    private UserRepo repo;

    @PostMapping("/Connexion")
    private ResponseEntity<String> registerUser(@RequestBody User user){
        //save the user
        user.setNom("user");
        user.setPrenom("user");
        user.setAddress("tunis");
        user.setMobile("26262626");
        user.setEmail("user.user@email.com");
        user.setSolde_autorisation(10);
        user.setSolde_congé(5);
        String msg = service.saveUser(user);

        return new ResponseEntity<String>(msg, HttpStatus.OK);
    }
    @PutMapping("/editUser/{matricule}")
    private ResponseEntity<String> updateUser(@RequestBody User user,@PathVariable("matricule")String mat)

    {
        String msg=service.updateUser(user,mat);
        return  new ResponseEntity<String>(msg,HttpStatus.OK);
    }




    @GetMapping ("/userbyToken/{fcmtoken}")
    public ResponseEntity<User> GetUserDetailsByToken(@PathVariable String fcmtoken) {
        return repo.findByFcmtoken(fcmtoken)
                .map(event -> new ResponseEntity<>(event, HttpStatus.OK))
                .orElseGet(() -> new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }
    @GetMapping ("/user/{matricule}")
    public ResponseEntity<User> GetUserDetailsByMatricule(@PathVariable String matricule) {
        return repo.findBymatricule(matricule)
                .map(event -> new ResponseEntity<>(event, HttpStatus.OK))
                .orElseGet(() -> new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }
    @GetMapping ("/users")
    public List<User> GetAllUsers() {
        return repo.findAll();
    }
    @GetMapping("/CheckUser/{matricule}")
    public ResponseEntity CheckUserByMatricule(@PathVariable("matricule")String matricule) throws ExecutionException {
        Optional<User> userr = repo.findBymatricule(matricule);

        return  userr.map(event -> new ResponseEntity<>(event, HttpStatus.OK))
                .orElseGet(() -> new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }


}
