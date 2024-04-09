

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpdesk/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';
class TicketDeatils extends StatefulWidget {

  var AllTickets;
  int i;
   TicketDeatils(this.AllTickets,this.i);

  @override
  State<TicketDeatils> createState() => _TicketDeatilsState();
}

class _TicketDeatilsState extends State<TicketDeatils> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF21899C),
        //elevation: 1,
        leading: InkWell(onTap: () {
          Navigator.of(context).pop();
        },child: Icon(Icons.arrow_back_ios,color: Colors.white)),

        title:  Text.rich(
          TextSpan(
            style:TextStyle(  fontSize: 23.12,
              color: Colors.white,
              letterSpacing: 1.999999953855673,),
            children: const [
              TextSpan(
                text: 'HELP',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
              TextSpan(
                text: ' DESK',
                style: TextStyle(
                  color: Color(0xFFFE9879),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
           Container(height: 20,),
            Container(
             decoration:BoxDecoration(color: Colors.white,boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 12)]) ,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      mainAxisAlignment:
                      MainAxisAlignment
                          .start,
                      children: [
                        Padding(
                          padding: const EdgeInsets
                              .only(
                              top:
                              10.0,
                              left:
                              10,right: 10,bottom: 10),
                          child: Row(
                              children: [
                                Container(
                                  width:
                                  100,
                                  child:
                                  Text(
                                    'Ticket No',
                                    style:  GoogleFonts.quicksand(fontWeight: FontWeight.bold),

                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width/1.5,
                                  child:
                                  Text.rich(
                                    TextSpan(
                                        children: [
                                          TextSpan(text: ": ", style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: Colors.black)),
                                          TextSpan(text: widget.AllTickets[widget.i]['TicketNo'], style: GoogleFonts.poppins(color: Colors.black))
                                        ]),
                                  ),
                                )
                              ]),
                        ),



                      ],
                    ),
                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      mainAxisAlignment:
                      MainAxisAlignment
                          .start,
                      children: [
                        Padding(
                          padding: const EdgeInsets
                              .only(
                              top:
                              10.0,
                              left:
                              10,right: 10,bottom: 10),
                          child: Row(
                              children: [
                                Container(
                                  width:
                                  100,
                                  child:
                                  Text(
                                    'Description',
                                    style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),

                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width/1.5,
                                  child:
                                  Text.rich(
                                    TextSpan(
                                        children: [
                                          TextSpan(text: ": ", style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: Colors.black)),
                                          TextSpan(text: widget.AllTickets[widget.i]['ShortText'], style: GoogleFonts.poppins(color: Colors.black))
                                        ]),
                                  ),
                                )
                              ]),
                        ),



                      ],
                    ),
                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      mainAxisAlignment:
                      MainAxisAlignment
                          .start,
                      children: [
                        Padding(
                          padding: const EdgeInsets
                              .only(
                              top:
                              10.0,
                              left:
                              10,right: 10,bottom: 10),
                          child: Row(
                              children: [
                                Container(
                                  width:
                                  100,
                                  child:
                                  Text(
                                    'Create Date',
                                    style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),

                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width/1.5,
                                  child:
                                  Text.rich(
                                    TextSpan(
                                        children: [
                                          TextSpan(text: ": ", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.black)),
                                          TextSpan(text: widget.AllTickets[widget.i]['DocDate'], style: GoogleFonts.poppins(color: Colors.black))
                                        ]),
                                  ),
                                )
                              ]),
                        ),



                      ],
                    ),
                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      mainAxisAlignment:
                      MainAxisAlignment
                          .start,
                      children: [
                        Padding(
                          padding: const EdgeInsets
                              .only(
                              top:
                              10.0,
                              left:
                              10,right: 10,bottom: 10),
                          child: Row(
                              children: [
                                Container(
                                  width:
                                  100,
                                  child:
                                  Text(
                                    'Created By',
                                    style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),

                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width/1.5,
                                  child:
                                  Text.rich(
                                    TextSpan(
                                        children: [
                                          TextSpan(text: ": ", style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: Colors.black)),
                                          TextSpan(text: widget.AllTickets[widget.i]['RaisedBy'], style: GoogleFonts.poppins(color: Colors.black))
                                        ]),
                                  ),
                                )
                              ]),
                        ),



                      ],
                    ),

                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      mainAxisAlignment:
                      MainAxisAlignment
                          .start,
                      children: [
                        Padding(
                          padding: const EdgeInsets
                              .only(
                              top:
                              10.0,
                              left:
                              10,right: 10,bottom: 10),
                          child: Row(
                              children: [
                                Container(
                                  width:
                                  100,
                                  child:
                                  Text(
                                    'Priority',
                                    style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),

                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width/1.5,
                                  child:
                                  Text.rich(
                                    TextSpan(
                                        children: [
                                          TextSpan(text: ": ", style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: Colors.black)),
                                          TextSpan(text: widget.AllTickets[widget.i]['Priority'], style: GoogleFonts.poppins(color: Colors.black))
                                        ]),
                                  ),
                                )
                              ]),
                        ),



                      ],
                    ),
                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      mainAxisAlignment:
                      MainAxisAlignment
                          .start,
                      children: [
                        Padding(
                          padding: const EdgeInsets
                              .only(
                              top:
                              10.0,
                              left:
                              10,right: 10,bottom: 10),
                          child: Row(
                              children: [
                                Container(
                                  width:
                                  100,
                                  child:
                                  Text(
                                    'Status',
                                    style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),

                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width/1.5,
                                  child:
                                  Text.rich(
                                    TextSpan(
                                        children: [
                                          TextSpan(text: ": ", style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: Colors.black)),
                                          TextSpan(text: widget.AllTickets[widget.i]['Status'], style: GoogleFonts.poppins(color: Colors.black))
                                        ]),
                                  ),
                                )
                              ]),
                        ),



                      ],
                    ),
                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      mainAxisAlignment:
                      MainAxisAlignment
                          .start,
                      children: [
                        Padding(
                          padding: const EdgeInsets
                              .only(
                              top:
                              10.0,
                              left:
                              10,right: 10,bottom: 10),
                          child: Row(
                              children: [
                                Container(
                                  width:
                                  100,
                                  child:
                                  Text(
                                    'Assigned To',
                                    style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),

                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width/1.5,
                                  child:
                                  Text.rich(
                                    TextSpan(
                                        children: [
                                          TextSpan(text: ": ", style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: Colors.black)),
                                          TextSpan(text: widget.AllTickets[widget.i]['AssignedTo'], style: GoogleFonts.poppins(color: Colors.black))
                                        ]),
                                  ),
                                )
                              ]),
                        ),



                      ],
                    ),
                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      mainAxisAlignment:
                      MainAxisAlignment
                          .start,
                      children: [
                        Padding(
                          padding: const EdgeInsets
                              .only(
                              top:
                              10.0,
                              left:
                              10,right: 10,bottom: 10),
                          child: Row(
                              children: [
                                Container(
                                  width:
                                  100,
                                  child:
                                  Text(
                                    'Closed By',
                                    style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),

                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width/1.5,
                                  child:
                                  Text.rich(
                                    TextSpan(
                                        children: [
                                          TextSpan(text: ": ", style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: Colors.black)),
                                          TextSpan(text: widget.AllTickets[widget.i]['ClosedBy'], style: GoogleFonts.poppins(color: Colors.black))
                                        ]),
                                  ),
                                )
                              ]),
                        ),



                      ],
                    ),
                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      mainAxisAlignment:
                      MainAxisAlignment
                          .start,
                      children: [
                        Padding(
                          padding: const EdgeInsets
                              .only(
                              top:
                              10.0,
                              left:
                              10,right: 10,bottom: 10),
                          child: Row(
                              children: [
                                Container(
                                  width:
                                  100,
                                  child:
                                  Text(
                                    'Closed On',
                                    style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),

                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width/1.5,
                                  child:
                                  Text.rich(
                                    TextSpan(
                                        children: [
                                          TextSpan(text: ": ", style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: Colors.black)),
                                          TextSpan(text: widget.AllTickets[widget.i]['ClosedOn'], style: GoogleFonts.poppins(color: Colors.black))
                                        ]),
                                  ),
                                )
                              ]),
                        ),



                      ],
                    ),
                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      mainAxisAlignment:
                      MainAxisAlignment
                          .start,
                      children: [
                        Padding(
                          padding: const EdgeInsets
                              .only(
                              top:
                              10.0,
                              left:
                              10,right: 10,bottom: 10),
                          child: Row(
                              children: [
                                Container(
                                  width:
                                  100,
                                  child:
                                  Text(
                                    'Department',
                                    style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),

                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width/1.5,
                                  child:
                                  Text.rich(
                                    TextSpan(
                                        children: [
                                          TextSpan(text: ": ", style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: Colors.black)),
                                          TextSpan(text: widget.AllTickets[widget.i]['Department'], style: GoogleFonts.poppins(color: Colors.black))
                                        ]),
                                  ),
                                )
                              ]),
                        ),



                      ],
                    ),

                  ],
                ))
        ],
      ),
    );
  }
}
