import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';
import 'package:riverpod_app/controller/controller.dart';
import 'package:riverpod_app/views/loading_widget.dart';

final controller = ChangeNotifierProvider(
  (ref) => Controller(),
);

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    ref.read(controller).getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var read = ref.read(controller);
    var watch = ref.watch(controller);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        title: const Text(
          "Users",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: LoadingWidget(
        isLoading: watch.isLoading,
        child: Padding(
          padding: 20.horizontalP,
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: OutlinedButton(
                        onPressed: () {
                          read.notSavedButton();
                        },
                        child: Text("Kullanıcılar ${watch.users.length}")),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 6,
                    child: OutlinedButton(
                        onPressed: () {
                          read.savedButton();
                        },
                        child:
                            Text("Kaydedilenler ${watch.savedUsers.length}")),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: PageView(
                  controller: watch.pageController,
                  children: [
                    notSaved(watch),
                    saved(watch),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView notSaved(Controller watch) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(borderRadius: 15.allBR),
            child: ListTile(
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(watch.users[index].avatar),
              ),
              title: Text(
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                "${watch.users[index].firstName} ${watch.users[index].lastName}",
              ),
              subtitle: Text(
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
                watch.users[index].email,
              ),
              trailing: IconButton(
                  onPressed: () {
                    watch.addSaved(watch.users[index]);
                  },
                  icon: const Icon(Icons.send_rounded)),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: watch.users.length);
  }

  ListView saved(Controller watch) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(borderRadius: 15.allBR),
            child: ListTile(
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(watch.savedUsers[index].avatar),
              ),
              title: Text(
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                "${watch.savedUsers[index].firstName} ${watch.savedUsers[index].lastName}",
              ),
              subtitle: Text(
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
                watch.savedUsers[index].email,
              ),
              trailing: IconButton(
                  onPressed: () {
                    watch.deleteSaved(watch.savedUsers[index]);
                  },
                  icon: const Icon(Icons.cancel_outlined)),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: watch.savedUsers.length);
  }
}
