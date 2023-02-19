class UserLocal {
	String id;
	String name;
	String email;
	bool isAdmin;
	bool isClient;
	String photoUrl;

	UserLocal({
		required this.id,
		required this.name,
		required this.email,
		this.photoUrl= '',
		this.isAdmin = false,
		this.isClient = false,
	});
}
