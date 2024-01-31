# Springboot Template walkthrough

[![Build Status][github-actions-svg]][github-actions]

This walkthrough will explain you how to correctly create a microservice from a Springboot Template using our DevOps Console.

## Current Version

This example is currently based on Java SE 11 (LTS)

## Create a microservice

In order to do so, access to [Mia-Platform DevOps Console](https://console.cloud.mia-platform.eu/login), create a new project and go to the **Design** area.  
From the Design area of your project select _Microservices_ and then create a new one, you have now reached [Mia-Platform Marketplace](https://docs.mia-platform.eu/development_suite/api-console/api-design/marketplace/)!  
In the marketplace you will see a set of Examples and Templates that can be used to set-up microservices with a predefined and tested function.  

For this walkthrough select the following example: **Springboot Template**.
Give your microservice the name you prefer, in this walkthrough we'll refer to it with the following name: **my-springboot-service-name**. Then, fill the other required fields and confirm that you want to create a microservice.  
A more detailed description on how to create a Microservice can be found in [Microservice from template - Get started](https://docs.mia-platform.eu/development_suite/api-console/api-design/custom_microservice_get_started/#2-service-creation) section of Mia-Platform documentation.

> :warning:
> Please once the service is installed in your project verify **Probes** confiugration, boot time of Springboot applications may be long
> so you might want to propertly tune readiness and liveness probes.

## Remove status probes

In order to run this example correctly, it is necessary to remove the default probes of your microservice. To do so, go to the table *Microservice configuration* of the newly created microservice *my-springboot-service-name* in the section *Probes*. Once here, delete both the default readiness and liveness paths.

## Expose an endpoint to your microservice

In order to access to your new microservice it is necessary to create an endpoint that targets it.  
In particular, in this walkthrough you will create an endpoint to your microservice *my-springboot-service-name*. To do so, from the Design area of your project select _Endpoints_ and then create a new endpoint.
Now you need to choose a path for your endpoint and to connect this endpoint to your microservice. Give to your endpoint the following path: **/springboot-template**. Then, specify that you want to connect your endpoint to a microservice and, finally, select *my-springboot-service-name*.  
Step 3 of [Microservice from template - Get started](https://docs.mia-platform.eu/development_suite/api-console/api-design/custom_microservice_get_started/#3-creating-the-endpoint) section of Mia-Platform documentation will explain in detail how to create an endpoint from the DevOps Console.

## Save your changes

After having created an endpoint to your microservice you should save the changes that you have done to your project in the DevOps console.  
Remember to choose a meaningful title for your commit (e.g "created service my_springboot_service_name"). After some seconds you will be prompted with a popup message which confirms that you have successfully saved all your changes.  
Step 4 of [Microservice from template - Get started](https://docs.mia-platform.eu/development_suite/api-console/api-design/custom_microservice_get_started/#4-save-the-project) section of Mia-Platform documentation will explain how to correctly save the changes you have made on your project in the DevOps console.

### GitOps

Usually, to start creating new features on a microservice, you need to create a branch. Due to the native support of this template to the SaMD development, the branch name should follow a specific convention, that is need to enhance traceability. The traceability is required by the IEC 62304 regulation for the SaMD development. The tool used for the branch naming check is [JHusky](https://github.com/Dathin/JHusky).

By default, the pattern for the branch naming convention is: `<type>-<implementation-task-id>-<description>`. Example: `feat-MC-1-login-endpoint`.
- The `<type>` part is related to the type of the implementation. The possible options are: feat, fix and doc;
- The `<implementation-task-id>` is the identifier of the implementation task. Usually, it is the Jira story code;
- The `<description>` is the description of the story. It should be a short recap of the story.

Moreover, for the same traceability requirement, also the commit messages should follow a specific convention, that is the following: `[<implementation-task-id>] <commit-description>`. Example: `[MC-1] Added login endpoint`.
- The `<implementation-task-id>` is the identifier of the implementation task. Usually, it is the Jira story code;
- The `<commit-description>` is the description of the commit.

If the branch has been named correctly, the implementation task identifier is inserted automatically in the commit message. Therefore, when you run the command `git commit -m "message"`, the commit message is automatically created as `[<implementation-task-id>] message`.

You can customize the branch naming convention by modifying the bash script that checks the branch name. In particular, you need to modify the regex in the `./scripts/check-branch-naming.sh` with your convention. You can also disable the check by removing the run of the `check-branch-naming.sh` bash script directly in the `./.husky/pre-commit` file.

Moreover, you can remove the automatic insertion of the implementation task identifier by removing the run of the `./scripts/prepare_commit_message.sh $1` command directly in the `./.husky/prepare-commit-msg` file. You can also customize the commit message, you need to modify the `./prepare_commit_message.sh` script.

## Deploy

Once all the changes that you have made are saved, you should deploy your project through the DevOps Console. Go to the **Deploy** area of the DevOps Console.  
Once here select the environment and the branch you have worked on and confirm your choices clicking on the *deploy* button. When the deploy process is finished you will receveive a pop-up message that will inform you.  
Step 5 of [Microservice from template - Get started](https://docs.mia-platform.eu/development_suite/api-console/api-design/custom_microservice_get_started/#5-deploy-the-project-through-the-api-console) section of Mia-Platform documentation will explain in detail how to correctly deploy your project.

## Try it

Now, if you copy/paste the following url in the search bar of your broser (remember to replace `<YOUR_PROJECT_HOST>` with the real host of your project):

```shell
https://<YOUR_PROJECT_HOST>/springboot-template/
```

you should see a *Whitelabel Error Page*. This behaviour is expected since this template has no routes defined.

Wonderful! You are now ready to start customizing your service! Read next section to learn how.

## Look inside your repository

Go back to _Microservices_, select *my-springboot-service-name* and access its git repository from the DevOps Console.  
Inside this repository you will find a [directory](https://github.com/mia-platform-marketplace/SpringBoot-Custom-Plugin-Template/tree/master/src/main/java/eu/miaplatform/customplugin/springboot) where you can find most of the source code of the template that you have created.

## Add a Welcome route

Add to this directory a file named **WelcomeController.java** with the following content:

```java

package eu.miaplatform.customplugin.springboot;

import eu.miaplatform.customplugin.springboot.Welcome;
import eu.miaplatform.customplugin.springboot.CPController;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

@RestController
@Api(value = "welcomeController")
public class WelcomeController extends CPController {

  @GetMapping("/")
  @ApiOperation(value = "welcome")
  @ResponseBody
  public Welcome sayWelcome() {
    return new Welcome("Welcome");
  }

}
```

As you can see from the above snippet of code, you have imported class *CPController* from [custom-plugin-java-springboot](https://github.com/mia-platform/custom-plugin-java-springboot), a library developed by Mia-Platform that contains configurations and functions useful for the setup of your Springboot service.

In line

```java
return new Welcome("Welcome");
```

you are creating an instance of a class called **Welcome**. You should now define what this class does in another file. In the same directory as before, create a file and call it **Welcome.java**. Copy/paste in it the following lines:

```java
package eu.miaplatform.customplugin.springboot;

public class Welcome {

    public String message;

    public Welcome(String message) {
        this.message = message;
    }
}
```

After committing these changes to your repository, you can go back to Mia Platform DevOps Console.  
Go to the **Deploy** area of the DevOps Console and deploy your project in a similar way to what you have done before modifying your git repository.

## Try it again

Once the deploy process is finished, go back to

```shell
https://<YOUR_PROJECT_HOST>/springboot-template/
```

or type the following in your terminal:

```shell
curl https://<YOUR_PROJECT_HOST>/springboot-template/
```

What you should see now is a very simple welcome message:

```json
{"message":"Welcome"}
```

Congratulations! You have successfully learnt how to use our Springboot Template on the DevOps Console!

[github-actions]: https://github.com/mia-platform-marketplace/SpringBoot-Custom-Plugin-Template/actions
[github-actions-svg]: https://github.com/mia-platform-marketplace/SpringBoot-Custom-Plugin-Template/workflows/Java%20CI%20with%20Maven/badge.svg
