[[java]] [[Spring]]

criteria queries allows us to do queries without writing any sql:
here is an example, we give the user multiple search criterias (age, salry  ......)
i we gonna hard code it we going to end-up with a huge amout of if statements, fortunately we can do it in just few lines using Criteria Queries.


we need to access our own dao:

``` java
//Employee DAO

@Repository
@RequiredArgsConstructor // Lombok
public class EmployeeSearchDao {
	private final  EntityManager em;
	
	public List<Employee> findAllBySimpleQuery(
		String fistname, 
		String lastname,
		String email
	){
		CriteriaBuilder criteriaBuilder = em.getCriteriaBuilder();
		CriteriaQuery<Employee> criteriaQuery = criteriaBuilder.createQuery(Employee.class); // the result class
		// select * from
		Root<Employee> root = criteriaQuery.from(Employee.class);
		// preparing the where clauses
		Predicate firstnamePredicate = criteriaBuilder.like(root.get("firstname/this is the column name"), ("%"+
		firstname +"%"))
		Predicate lastnamePredicate = criteriaBuilder.like(root.get("firstname/this is the column name"), ("%"+
		firstname +"%"))
		Predicate lastnamePredicate = criteriaBuilder.like(root.get("firstname/this is the column name"), ("%"+
		firstname +"%"))
		Predicate orPredicate = criteriaBuilder.or(firstNamePredicate , LastNamePredicate);
		
		criteriaQuery.where(orPredicate);
	}
}
```
