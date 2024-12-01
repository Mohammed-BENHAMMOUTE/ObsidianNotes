[[Projects]]

### File Structure:
	-> Controller
	-> model : here we define the model of the data we want to        use  for example Article, Product , user...
	-> repository: is where we intarsct eith the database.
	-> service
	

in the Ariclerepository to interact wit the database, we need to use a Jdbc Template so it will be part of the Class, and in the constructure passed as argument.
next when working with jdbc we need a rowMapper . A RowMapper is used in Spring's JDBC framework to map rows of a ResultSet to Java objects.

```java
private final RowMapper<Article> rowMapper = (rs, rowNum) -> {  
    Article article = new Article();  
    article.setId(rs.getLong("id"));  
    article.setTitle(rs.getString("title"));  
    article.setAuthor(rs.getString("author"));  
    article.setContent(rs.getString("content"));  
    article.setTags((String[]) rs.getArray("tags").getArray());  
    return article;  
};
```

next whenever we use  the jdbc template to execute a query or a update. we pass the RowMapper in the arguments.

```java
public List<Article> findAll() {  
    String sql = "SELECT * FROM articles ORDER BY publish_date DESC";  
    return jdbcTemplate.query(sql, rowMapper);  
};
```


+ When we execute a query to find an element in the database that we are no sure it will be found or not we can use the `Optional<Object>`  where the object is the instance of the class we want for the output.
  here is an example:
  ```java
  public Optional<Article> findById (Long Id) {  
    String sql  = "SELECT * FROM articles WHERE id = ?";  
    List<Article>  results = jdbcTemplate.query(sql, rowMapper, Id);  
    return results.isEmpty() ? Optional.empty() : Optional.of(results.get(0));  
};
```
	if the result is not found we return Optional.empty() object.

+ another cool trick is when we save an data to the database, of course we can always use the prepared statements.
  when  we use prepared statements that will get data from th eobject dynamically  we should use connection as a lambda function inside of the  `jdbc.update()`, as in this example:
  ```java
public void update(Article article) {  
    String sql  = "UPDATE articles SET title = ?, content = ?, tags = ?, author = ?, publish_date = ? WHERE id = ?";  
    jdbcTemplate.update( con -> {  
        PreparedStatement ps = con.prepareStatement(sql);  
        ps.setString(1, article.getTitle());  
        ps.setString(2, article.getContent());  
        ps.setArray(3, con.createArrayOf("text", article.getTags()));  
        ps.setString(4, article.getAuthor());  
        ps.setTimestamp(5, Timestamp.valueOf(article.getPublishDate()));  
        ps.setLong(6, article.getId());  
        return ps;  
    });};  
public void deleteById(Long id) {  
    String sql = "DELETE FROM articles WHERE id = ?";  
    jdbcTemplate.update(sql, id);  
};
```
+ as you can see we use the sql string as an argument in the prepared statement of the PreparedStaement object and in case . as you can see the lambda func inserts the info in the prepared statement and returns it immediately.
