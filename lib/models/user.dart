class UserLocal {
	String id;
	String name;
	String email;
	bool isAdmin;
	bool isClient;

	UserLocal({
		required this.id,
		required this.name,
		required this.email,
		this.isAdmin = false,
		this.isClient = false,
	});
}
