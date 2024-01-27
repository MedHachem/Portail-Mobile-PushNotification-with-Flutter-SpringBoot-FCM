package gti.app.notifications.model;


import jdk.nashorn.internal.ir.annotations.Immutable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;


@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "user_tab")//for the table name
@Immutable
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private String matricule;
    private String nom;
    private String prenom;
    private String email;
    private String mdp;
    private String mobile;
    private String address;
    private float solde_congé;
    private float solde_autorisation;
    private String fcmtoken;
}