[[Spring]]
Jpa is just the specification, hibernate is the implementation, there is another implementation which is EclipseLink,

the class annotated with `@Entity`, must have a public or protected no args constructor , it can also have other constructor.
two steps, mapping the class to the database table, and then mapping the fields to the columns.


its recommanded to use the @Table and @Column names to prevent breaking changes. 

```java
@Entity
@Table(name="student")
public class Student {
	@Id	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="student_id")
	Long id;
}
```
generated value means that its managaed by the database.
there are four major generation types:

| Name                      | Description                                                                  |
| ------------------------- | ---------------------------------------------------------------------------- |
| GenerationType.AUTO       | Pick an appropriate strategy for the particular database.                    |
| GenererationType.IDENTITY | Assign primery keys using database identity column                           |
| GenerationType.SEQUENCE   | Assign primary keys using a database sequence                                |
| GenerationType.TABLE      | Assign primary keys using an underlying database table to ensure uniqueness. |
u can create your own custum generation type.
create an implementation of the org.hibernate.id.IdentifierGenerator
Override the method: public Serializable generate(...)

9