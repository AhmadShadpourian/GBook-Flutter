class Book {
  late String id;
  late String selfLink;
  late String title;
  late String subtitle;
  late String authors;
  late String publisher;
  late String publishedDate;
  late String description;
  late String categories;
  late String averageRating;
  late String image;
  late bool favorite;

  Book(
      {required this.id,
      required this.selfLink,
      required this.title,
      required this.subtitle,
      required this.authors,
      required this.publisher,
      required this.publishedDate,
      required this.description,
      required this.categories,
      required this.averageRating,
      required this.image,
      required this.favorite});

  Book.fromJson(Map<String, dynamic> parsedJson) {
    Map volumeInfo = parsedJson["volumeInfo"];

    id = parsedJson['id'];
    selfLink = parsedJson['selfLink'] != null ? parsedJson['selfLink'] : "";
    title = volumeInfo.containsKey("title")
        ? parsedJson['volumeInfo']['title']
        : "No Title";
    subtitle = volumeInfo.containsKey("subtitle")
        ? parsedJson['volumeInfo']['subtitle']
        : "No Subtitle";
    authors = volumeInfo.containsKey("authors")
        ? parsedJson['volumeInfo']['authors'][0]
        : "NO Author";
    publisher = volumeInfo.containsKey("publisher")
        ? parsedJson['volumeInfo']['publisher']
        : "NO Publisher";
    publishedDate = volumeInfo.containsKey("publishedDate")
        ? parsedJson['volumeInfo']['publishedDate']
        : "No PublishedDate";
    description = volumeInfo.containsKey("description")
        ? parsedJson['volumeInfo']['description']
        : "NO Description";
    categories = volumeInfo.containsKey("categories")
        ? parsedJson['volumeInfo']['categories'][0]
        : "NO Category";
    averageRating = volumeInfo.containsKey("averageRating")
        ? parsedJson['volumeInfo']['averageRating'].toString()
        : "NO Rating";
    image = volumeInfo.containsKey("imageLinks")
        ? parsedJson['volumeInfo']['imageLinks']['thumbnail'] == ""
            ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png"
            : parsedJson['volumeInfo']['imageLinks']['thumbnail']
        : "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png";

    favorite = false;
  }
}
