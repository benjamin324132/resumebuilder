import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resumebuilder/Components/cutsom_button.dart';
import 'package:resumebuilder/Screens/resume_preview.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../Components/added_item.dart';
import '../Components/text_field.dart';
import '../Models/resume.dart';
import '../Utils/utils.dart';

class ResumeBuilderScreen extends StatefulWidget {
  const ResumeBuilderScreen({Key? key}) : super(key: key);

  @override
  State<ResumeBuilderScreen> createState() => _ResumeBuilderScreenState();
}

class _ResumeBuilderScreenState extends State<ResumeBuilderScreen> {
  Resume resume = Resume(works: [], education: [], skills: []);
  TextEditingController name = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController bio = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController location = TextEditingController();

  //WORK
  TextEditingController workEnterpraise = TextEditingController();
  TextEditingController workTitle = TextEditingController();
  TextEditingController workDescription = TextEditingController();

  //Education
  TextEditingController eduSchool = TextEditingController();
  TextEditingController edutitle = TextEditingController();
  TextEditingController eduDescription = TextEditingController();

  //Skills
  TextEditingController skilltitle = TextEditingController();

  bool isEditingWorks = false;
  String? workIdSelected;

  bool isEditingEducation = false;
  String? educationIdSelected;

  bool isEditingSkills = false;
  String? skillIdSelected;

  void previewResume() {
    resume.name = name.text;
    resume.title = title.text;
    resume.bio = bio.text;
    resume.phone = phone.text;
    resume.email = email.text;
    resume.location = location.text;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ResumePrevie(resume: resume),
      ),
    );
  }

//WORKS
  void addWorkExperience() {
    if (isEditingWorks) {
      final index =
          resume.works.indexWhere((element) => element.id == workIdSelected);
      if (index != -1) {
        Works work = Works(
            id: idGenerator(),
            title: workTitle.text,
            enterpraise: workEnterpraise.text,
            description: workDescription.text);
        setState(() {
          resume.works[index] = work;
          workTitle.text = "";
          workEnterpraise.text = "";
          workDescription.text = "";
          isEditingWorks = false;
        });
      }
    } else {
      Works work = Works(
          id: idGenerator(),
          title: workTitle.text,
          enterpraise: workEnterpraise.text,
          description: workDescription.text);

      setState(() {
        resume.works.add(work);
        workTitle.text = "";
        workEnterpraise.text = "";
        workDescription.text = "";
      });
    }
  }

//EDUCATION
  void addEducation() {
    if (isEditingEducation) {
      final index = resume.education
          .indexWhere((element) => element.id == educationIdSelected);
      if (index != -1) {
        Education education = Education(
            id: idGenerator(),
            title: edutitle.text,
            school: eduSchool.text,
            description: eduDescription.text);
        setState(() {
          resume.education[index] = education;
          edutitle.text = "";
          eduSchool.text = "";
          eduDescription.text = "";
          isEditingEducation = false;
        });
      }
    } else {
      Education education = Education(
          id: idGenerator(),
          title: edutitle.text,
          school: eduSchool.text,
          description: eduDescription.text);

      setState(() {
        resume.education.add(education);
        edutitle.text = "";
        eduSchool.text = "";
        eduDescription.text = "";
      });
    }
  }

  void addSkill() {
    if (isEditingSkills) {
      final index =
          resume.skills.indexWhere((element) => element.id == skillIdSelected);
      if (index != -1) {
        Skills skill = Skills(
          id: idGenerator(),
          title: skilltitle.text,
        );
        setState(() {
          resume.skills[index] = skill;
          skilltitle.text = "";
          isEditingSkills = false;
        });
      }
    } else {
      Skills skill = Skills(
        id: idGenerator(),
        title: skilltitle.text,
      );
      setState(() {
        resume.skills.add(skill);
        skilltitle.text = "";
      });
    }
  }

  void pickResumeImage() async {
    var file = await pickImage(ImageSource.gallery);
    if (file != null) {
      resume.image = File(file.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ExpansionTile(
                  title: Text(
                    AppLocalizations.of(context).personalInfo,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  children: <Widget>[
                    CustomButton(
                      onPress: pickResumeImage,
                      text: AppLocalizations.of(context).pickImage,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldComponent(
                      text: name,
                      placeholder: AppLocalizations.of(context).name,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldComponent(
                      text: title,
                      placeholder: AppLocalizations.of(context).title,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldComponent(
                      text: bio,
                      placeholder: AppLocalizations.of(context).bio,
                      maxLines: 5,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldComponent(
                      text: phone,
                      placeholder: AppLocalizations.of(context).phone,
                      type: TextInputType.phone,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldComponent(
                      text: email,
                      placeholder: "Email",
                      type: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldComponent(
                      text: location,
                      placeholder: AppLocalizations.of(context).location,
                      type: TextInputType.streetAddress,
                    ),
                  ]),
              const SizedBox(
                height: 15,
              ),
              ExpansionTile(
                title: Text(
                  AppLocalizations.of(context).workExperience,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                children: <Widget>[
                  ...resume.works.map((work) => AddedItem(
                        title: "${work.title}",
                        onEdit: () {
                          setState(() {
                            isEditingWorks = true;
                            workIdSelected = work.id;
                            workTitle.text = "${work.title}";
                            workEnterpraise.text = "${work.enterpraise}";
                            workDescription.text = "${work.description}";
                          });
                        },
                        onDelete: () {
                          final index = resume.works
                              .indexWhere((element) => element.id == work.id);
                          if (index != -1) {
                            resume.works.removeAt(index);
                          }
                          setState(() {});
                        },
                      )),
                  Column(
                    children: <Widget>[
                      TextFieldComponent(
                        text: workTitle,
                        placeholder: AppLocalizations.of(context).workTitle,
                        type: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFieldComponent(
                        text: workEnterpraise,
                        placeholder:
                            AppLocalizations.of(context).workEnterpraise,
                        type: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFieldComponent(
                        text: workDescription,
                        placeholder: AppLocalizations.of(context).workDesc,
                        type: TextInputType.text,
                        maxLines: 3,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomButton(
                        onPress: addWorkExperience,
                        text: isEditingWorks
                            ? AppLocalizations.of(context).update
                            : AppLocalizations.of(context).add,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              ExpansionTile(
                title: Text(
                  AppLocalizations.of(context).education,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                children: <Widget>[
                  ...resume.education.map((edu) => AddedItem(
                        title: "${edu.school}",
                        onEdit: () {
                          setState(() {
                            isEditingEducation = true;
                            educationIdSelected = edu.id;
                            edutitle.text = "${edu.title}";
                            eduSchool.text = "${edu.school}";
                            eduDescription.text = "${edu.description}";
                          });
                        },
                        onDelete: () {
                          final index = resume.education
                              .indexWhere((element) => element.id == edu.id);
                          if (index != -1) {
                            resume.education.removeAt(index);
                          }
                          setState(() {});
                        },
                      )),
                  Column(
                    children: <Widget>[
                      TextFieldComponent(
                        text: edutitle,
                        placeholder: AppLocalizations.of(context).schoolTitle,
                        type: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFieldComponent(
                        text: eduSchool,
                        placeholder: AppLocalizations.of(context).school,
                        type: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFieldComponent(
                        text: eduDescription,
                        placeholder: AppLocalizations.of(context).description,
                        type: TextInputType.text,
                        maxLines: 3,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomButton(
                        onPress: addEducation,
                        text: isEditingEducation
                            ? AppLocalizations.of(context).update
                            : AppLocalizations.of(context).add,
                      ),
                    ],
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(
                  AppLocalizations.of(context).skills,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                children: <Widget>[
                  ...resume.skills.map((skill) => AddedItem(
                        title: "${skill.title}",
                        onEdit: () {
                          setState(() {
                            isEditingSkills = true;
                            skillIdSelected = skill.id;
                            skilltitle.text = "${skill.title}";
                          });
                        },
                        onDelete: () {
                          final index = resume.skills
                              .indexWhere((element) => element.id == skill.id);
                          if (index != -1) {
                            resume.skills.removeAt(index);
                          }
                          setState(() {});
                        },
                      )),
                  Column(
                    children: <Widget>[
                      TextFieldComponent(
                        text: skilltitle,
                        placeholder: AppLocalizations.of(context).skill,
                        type: TextInputType.text,
                      ),
                      CustomButton(
                        onPress: addSkill,
                        text: isEditingSkills
                            ? AppLocalizations.of(context).update
                            : AppLocalizations.of(context).add,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              CustomButton(
                onPress: previewResume,
                text: AppLocalizations.of(context).preview,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
