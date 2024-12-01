[[Spring]]

pour une relation bidirectionnelle on doit utiliser les annotations de `manyToOne` et `oneToMany`
![[Pasted image 20240901181504.png]]
as you can see the the relation between Patient and RendezVous is bi-directionnel, and there for we have to have a collection of RendezVous in the Patient entitie, this tells spring that this is a stranger key, in the RendezVous Class we need an attribute of Patient with the annotation of oneToMany

```java
@Entity
@Data @AllArgsConstructor @NoArgsConstructor
public class Patient {
	@Id @GenratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String nom;
	private String email;
	@oneToMany(mappedBy= "patient" fetch = FetchType.LAZY // or EAGER see the explination bellow)
	private collection<RendezVous> rendezVous;
}
```

```java
@Entity
@Data @NoArgsConstructor @AllArgsConstructor
public class RendezVous {
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long Id;
	private Date RendezVous;
	@ManyToOne
	private Patient patient;
}

```

+ with fetch = FetchType.LAZY , we get only the fielads that are not marked `oneToMany` meaning we only get the necessary information. with eager we get all the fields.
we use the `EAGER` Property when we have a relation of composition.

Lorsqu'on utilise EAGER il faut initialiser la collection,
par example:
![[Pasted image 20240902112009.png]]
```java
@Entity
@Data @NoArgsConstructor @AllArgsConstructor
public class Utilisateur {
	@Id @GeneeatedValue( strategy = GenerationType.IDENTITY)
	private Long Identity;
	@Column(unique = true)
	private String userName;
	private String password;
	@ManyToMany(mappedBy = "utilisateurs" fetch = FetchType.EAGER)
	private collection<Groupe> groupes = new ArrayList<>();
}
```

```java
@Entity
@Data @NoArgsConstructor @AllArgsConstructor
public class Groupe {
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	@Column(unique = true)
	private String groupeName;
	@ManyToMany(fetch = FecthStrategy.EAGER)
	private Collection<Utilisateur> utilisateurs = new ArrayList<>(); 
}
```

il faut toujours initialiser le champs de la relation eager. parceque si on essaye de faire une operation sur ce champs il ne doit pas etre empty(null).


## Comment gerer une association many to many:
```java
public interface UserRepository extends JpaRepository<Utilisateur , Long> {
	Utilisateur findByUserName(String userName);
}
```

```java
public interface GroupeRepository extends JpaRepository<Groupe, Long> {
	Groupe findByGroupeName(String groupeName);
} 
```

```java
public interface UserService {
	Utilisateur saveUser( Utilisateur utilisateur);
	Groupe saveGroupe(Groupe groupe);
	void addUserToGroup(String  utilisateur,String groupe);
	void findByUserName(String userName);
};
```

```java
@Service
@TRansactional
public class UsersServiceImp implements UserService {
	@Autowired
	private UserRepository userRepository;
	@Autowired
	private GroupeRepository groupeRepository;
	@Override
	public Utilisater saveUser(Utilisateur utilisateur){
		userRepository.save(utilisateur);	
	};
	@Override
	public Groupe saveGroupe(Groupe groupe){
		groupeRepository.save(groupe);
	};
	@Override
	void addUserToGroupe(String userName, String groupeName)
	{
		Utilisateur user = userRepository.findByUserName(userName);
		Groupe groupe = groupeRepository.findByGroupeName(groupeName);
		groupe.getUtilisateurs.add(user);
	};
	@Override
	Utilisateur findByUserName(String name){
		return userRepository.findByUserName(userName);
	}
}
```


## Cas de ManyToMany avec un attribut supplimentaire dans la classe d'association

![[Pasted image 20240902123957.png]]
dans ce cas on  aura :
```java
@Entity
@Data @NoArgsConstructor @AllArgsConstructor
public class Cours {
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String nom;
	private int volumeHoraire;
	@OneToMany(mappedBy = "cours")
	private collection<Inscription> inscriptions; 
};
```

```java
public interface coursRepository<Cours, Long> {}
```

```java
@Entity
@Data @NoArgsConstructor @AllArgsConstructor
public class Etudiant {
	@Id @GeneratedValue(strategy = GeneratedValue.IDENTITY)
	private Long id;
	private String nom;
	private String prenom;
	@OneToMany(mappedBy = "cours")
	private Collection<Inscription> inscriptions;	
}
```

```java
@Entity 
@Data @NoArgsConstructor @AllArgsConstructor
public class Inscription {
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private Date dateInscription;
	private double Score;
	@ManyToOne
	private Etudiant etudiant;
	@ManyToOne
	private Cours cours;
}
```


## Mapping des heritages:
trois strategy pour mapper l'heritage;
1. Une table par Hierarchie(**SINGLE-table**).
2. Une table pour chaque classe concrete(**TABLE_PER_CLASS**)
3. Une table pour la classe parente et une class pour chaque class fille.(**JOINED_TABLE**). 

## 1. mapping de l'heritage avec single Table.
```java
@Entity
@Data @NoArgsConstructor @AllArgsConstructor
@Inheritance (strategy = ImheritanceType.SINGLE_TABLE)
@DescriminatoryColumn(name = "TYPE", length = 4)
public absract class  Personne {
	@Id @GeneratedValue(stratgy = GenerationType.IDENTITY)
	private Long id;
	private String nom;
	private Date dateNaissance;
}
```

```java
public interface PersonneRepository extends JPARepository<Personne, Long> {}
```