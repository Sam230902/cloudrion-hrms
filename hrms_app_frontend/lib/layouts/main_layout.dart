import 'package:flutter/material.dart';

import '../widgets/sidebar.dart';
import '../widgets/topbar.dart';


class MainLayout extends StatefulWidget {

  final String role;
  final String title;
  final String userName;
  final Widget child;
  final Function(String)? onMenuTap;
  final VoidCallback onLogout;

  const MainLayout({
    super.key,
    required this.role,
    required this.title,
    required this.userName,
    required this.child,
    required this.onLogout,
    this.onMenuTap,
  });

  @override
  State<MainLayout> createState() =>
      _MainLayoutState();
}

class _MainLayoutState
    extends State<MainLayout> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xffF5F6FA),

      body: Row(
        children: [

          // ================= SIDEBAR =================
          Sidebar(

            role: widget.role,

            onMenuTap: (menu) {

              // ================= CALLBACK =================
              if(widget.onMenuTap != null) {

                widget.onMenuTap!(menu);
              }
            },
          ),

          // ================= RIGHT SIDE =================
          Expanded(

            child: Column(
              children: [

                // ================= TOPBAR =================
                Topbar(
                   role: widget.role,

                  title: widget.title,

                  userName:
                      widget.userName,

                  onLogout:
                      widget.onLogout,
                ),

                // ================= PAGE CONTENT =================
                Expanded(

                  child: Container(

                    width: double.infinity,

                    padding:
                        const EdgeInsets.all(
                      20,
                    ),

                    child: widget.child,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}