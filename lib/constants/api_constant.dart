const protocol = "http";
const domain = "10.4.177.239:3000";
const wardrobeURLAPI = "$protocol://$domain/api/wardrobe";

Map<String, String> setHeaders() {
  return {
    'Content-Type':'application/json',
    'Accept':'application/json'
  };
}