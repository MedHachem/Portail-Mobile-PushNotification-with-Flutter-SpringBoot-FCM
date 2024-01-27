package gti.app.notifications.service;

import gti.app.notifications.Repository.UserRepo;
import gti.app.notifications.model.User;
import gti.app.notifications.model.UserResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.Optional;
import java.util.concurrent.ExecutionException;


@Service
public class UserService {

    @Autowired
    private UserRepo repo;
    private Logger logger = LoggerFactory.getLogger(PushNotificationService.class);

    public String saveUser(User user) {
        repo.save(user);
        return "Utilisateur bien enregistré !!!!";
    }

    public String updateUser(User user,String mat) {
        User userr = repo.findByMatricule(mat);
        userr.setNom(user.getNom());
        userr.setPrenom(user.getPrenom());
        userr.setMdp(user.getMdp());
        userr.setAddress(user.getAddress());
        userr.setMobile(user.getMobile());
        userr.setSolde_autorisation(user.getSolde_autorisation());
        userr.setSolde_congé(user.getSolde_congé());
         repo.save(userr);
         return "Mise à jour bien établie ";
    }




}

